export BUCKET=$(gcloud config list project --format "value(core.project)")
export PROJECT_ID=sod-corp-plp-beta
export PIPELINE_FOLDER=sodimac

python -m messagetogcs \
--project ${PROJECT_ID} \
--input /path/to/inputfile \
--output gs://${BUCKET}/ \
--topic productUpdated \
--subscription projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake \
--stagingLocation gs://${BUCKET}/dataflow/pipelines/${PIPELINE_FOLDER}/staging \
--tempLocation gs://${BUCKET}/dataflow/pipelines/${PIPELINE_FOLDER}/temp \
--entityType product \
--eventType productUpdated \
--outputFilenamePrefix windowed-file \
--outputFilenameSuffix .json





--project=${PROJECT_ID} \
--stagingLocation=gs://${BUCKET}/dataflow/pipelines/${PIPELINE_FOLDER}/staging \
--tempLocation=gs://${BUCKET}/dataflow/pipelines/${PIPELINE_FOLDER}/temp \
--jobName=sodimac-catalog-datalake \
--runner=DataflowRunner \
--windowDuration=2m \
--entityType=product \
--eventType=productUpdated \
 \
--numShards=1 \
--inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake \
--outputDirectory=gs://${BUCKET}/ \
 \
"
