import apache_beam as beam
import argparse
import logging
import apache_beam.transforms.window as window
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.options.pipeline_options import SetupOptions
from apache_beam.options.pipeline_options import StandardOptions
from apache_beam.io.textio import ReadFromPubSub, WriteToText


def run(argv=None):

    """Main entry point; defines and runs the wordcount pipeline."""
    parser = argparse.ArgumentParser()
    parser.add_argument('--input',
                        dest='input',
                        required=True,
                        default='gs://dataflow-samples/shakespeare/kinglear.txt',
                        help='Input file to process.')
    parser.add_argument('--output',
                        dest='output',
                        required=True,
                        default='gs://dataflow-samples/',
                        help='Output file to write results to.')
    parser.add_argument('--topic',
                        dest='topic',
                        required=True,
                        help='Topic for message.')
    parser.add_argument('--subscription',
                        dest='subscription',
                        required=True,
                        help='Subscription for message.')
    parser.add_argument('--entity_type',
                        dest='entity_type',
                        required=True,
                        help='Entity Type for message.')
    parser.add_argument('--event_type',
                        dest='event_type',
                        required=True,
                        help='Event Type for message.')                        
    parser.add_argument('--outputFilenamePrefix',
                        dest='outputFilenamePrefix',
                        required=True,
                        help='Output Filename Prefix Type for message.')   
    parser.add_argument('--outputFilenameSuffix',
                        dest='outputFilenameSuffix',
                        required=True,
                        help='Output Filename Suffix Type for message.') 

    known_args, pipeline_args = parser.parse_known_args(argv)

    # We use the save_main_session option because one or more DoFn's in this
    # workflow rely on global context (e.g., a module imported at module level).
    pipeline_options = PipelineOptions(pipeline_args)
    pipeline_options.view_as(SetupOptions).save_main_session = True
    pipeline_options.view_as(StandardOptions).streaming= True
    p = beam.Pipeline(options=pipeline_options)

    if known_args.subscription:
        messages = (p 
                | beam.io.ReadFromPubSub(subscription=known_args.subscription)
                .with_output_types(bytes))
    else:
        messages = (p 
                | beam.io.ReadFromPubSub(subscription=known_args.topic)
                .with_output_types(bytes))
    
    lines = messages | 'decode' >> beam.Map(lambda x: x.decode('utf-8'))

    data = (lines 
                | beam.WindowInto(window.FixedWindows(120,0))
                | beam.io.WriteToText(known_args.output + known_args.outputFilenamePrefix, 
                                    file_name_suffix=known_args.outputFilenameSuffix,
                                    num_shards=1))

    result = p.run()
    result.wait_until_finish()

if __name__ == "__main__":
    logging.getLogger().setLevel(logging.INFO)
    run()






