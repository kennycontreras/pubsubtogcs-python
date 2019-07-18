export BUCKET=sod-plp-search
export PROJECT_ID=$(gcloud config list project --format "value(core.project)")
export PIPELINE_FOLDER=sodimac

python -m messagetogcs \
    --runner DataflowRunner \
    --job_name entity-price \
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
    --outputFilenameSuffix .json \
    --streaming

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


 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake --filter="ATTRIBUTES.entityType=ATG_Ship_Anywhere"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake --filter="ATTRIBUTES.entityType=ATG_FACILITY_LEVEL"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake --filter="ATTRIBUTES.entityType=ATG_Pickup_Reg_1_Stores"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake --filter="ATTRIBUTES.entityType=ATG_Pickup_Reg_2_Stores"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake --filter="ATTRIBUTES.entityType=ATG_REGIONAL_SHIPPING"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake --filter="ATTRIBUTES.entityType=ATG_Total_Network"

 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake --filter="ATTRIBUTES.entityType=product"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake --filter="ATTRIBUTES.entityType=brand"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake --filter="ATTRIBUTES.entityType=category"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake --filter="ATTRIBUTES.entityType=sku_collection"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake --filter="ATTRIBUTES.entityType=connect_item"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake --filter="ATTRIBUTES.entityType=connect_plan"
 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake --filter="ATTRIBUTES.entityType=recomendados"

 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake --format="json(ackId, message.attributes, message.data.decode(\"base64\"), message.messageId, message.publishTime)" --filter="ATTRIBUTES.entityType=product"

 gcloud pubsub subscriptions pull projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake --format="json(ackId, message.attributes, message.data.decode(\"base64\"), message.messageId, message.publishTime)" --filter="ATTRIBUTES.entityType=sku_collection" --filter="ATTRIBUTES.entityType=price"




 gs://sod-plp-search/dataflow-temp/pubsubtopubsub/


 gcloud beta dataflow jobs run entity-price \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-price-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/price,\
 filterKey=entityType,\
 filterValue=price


 gcloud beta dataflow jobs run entity-price-group \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-price-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/price-group,\
 filterKey=entityType,\
 filterValue=priceGroup

 ### CATALOGO

 gcloud beta dataflow jobs run entity-brand \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/brand,\
 filterKey=entityType,\
 filterValue=brand


 gcloud beta dataflow jobs run entity-category \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/category,\
 filterKey=entityType,\
 filterValue=category


 gcloud beta dataflow jobs run entity-variant \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/variant,\
 filterKey=entityType,\
 filterValue=variant


 gcloud beta dataflow jobs run entity-product \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/product,\
 filterKey=entityType,\
 filterValue=product


 gcloud beta dataflow jobs run entity-promotion \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/promotion,\
 filterKey=entityType,\
 filterValue=promotion


 gcloud beta dataflow jobs run entity-zone-catalog \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-catalog-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/zone,\
 filterKey=entityType,\
 filterValue=zone


 ### AVAILABLE

 gcloud beta dataflow jobs run entity-facility \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/facility,\
 filterKey=entityType,\
 filterValue=facility


 gcloud beta dataflow jobs run entity-sku-collection \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/sku-collection,\
 filterKey=entityType,\
 filterValue=skuCollection



 gcloud beta dataflow jobs run entity-threshold-stock \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/threshold-stock,\
 filterKey=entityType,\
 filterValue=thresholdStock


 gcloud beta dataflow jobs run entity-zone-availability \
     --gcs-location gs://dataflow-templates/2019-07-03-00/Cloud_PubSub_to_Cloud_PubSub \
     --worker-machine-type=n1-standard-1 \
     --parameters \
 inputSubscription=projects/sod-corp-plp-beta/subscriptions/sodimac-availability-datalake,\
 outputTopic=projects/sod-corp-plp-beta/topics/zone,\
 filterKey=entityType,\
 filterValue=zone
