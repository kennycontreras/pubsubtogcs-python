import apache_beam as beam
import argparse
import logging
import apache_beam.transforms.window as window
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.options.pipeline_options import SetupOptions
from apache_beam.options.pipeline_options import StandardOptions


def run(argv=None):

    """Main entry point; defines and runs the wordcount pipeline."""
    parser = argparse.ArgumentParser()
    parser.add_argument('--project',
                        dest='project',
                        required=True,
                        help='Project ID provided.')
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
    parser.add_argument('--entityType',
                        dest='entityType',
                        required=True,
                        help='Entity Type for message.')
    parser.add_argument('--eventType',
                        dest='eventType',
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
    pipelineoptions = PipelineOptions(pipeline_args)
    pipelineoptions.view_as(SetupOptions).save_main_session = True
    pipelineoptions.view_as(StandardOptions).streaming=True
    p = beam.Pipeline(options=pipelineoptions)
    

    print(known_args.output + known_args.outputFilenamePrefix)

    if known_args.subscription:
        message = (p 
                | beam.io.ReadFromPubSub(subscription=known_args.subscription)
                .with_output_types(bytes))
    else:
        message = (p 
                | beam.io.ReadFromPubSub(subscription=known_args.topic)
                .with_output_types(bytes))
    
    data = (message 
                | beam.WindowInto(window.FixedWindows(120,0))
                | beam.io.WriteToJson(known_args.output + known_args.outputFilenamePrefix, file_name_suffix=known_args.outputFilenameSuffix))

if __name__ == "__main__":
    logging.getLogger().setLevel(logging.INFO)
    run()





