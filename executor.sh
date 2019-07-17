export BUCKET=sod-plp-search
export PROJECT_ID=$(gcloud config list project --format "value(core.project)")
export PIPELINE_FOLDER=sodimac

python -m messagetogcs \
    --runner DataflowRunner \
    --project sod-corp-plp-beta \
    --input /path/to/inputfile \
    --output gs://${BUCKET}/ \
    --topic projects/sodimac-catalyst-bu-prod/topics/sodimac-price \
    --subscription projects/sod-corp-plp-beta/subscriptions/sodimac-entity-price-all \
    --staging_location gs://${BUCKET}/dataflow/pipelines/${PIPELINE_FOLDER}/staging \
    --temp_location gs://${BUCKET}/dataflow/pipelines/${PIPELINE_FOLDER}/temp \
    --entity_type price \
    --event_type priceUpdated \
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
