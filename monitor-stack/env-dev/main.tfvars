env             ="dev"
zone_id         ="Z08142241SY16ZULZO1LU"
vpc_name        ="default_vpc_south2"
subnet_name     ="default-ap-south-2c"
ami_id          ="ami-0e86c549c4c958e98"
# fill details



ec2_instance={
   monitor={
        instance_type ="t3.large" #"r6i.large"
        volume_size   =30
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonS3ReadOnlyAccess"]
        server_port={
                ssh={
                    port="22"
                }
                grafana={
                    port="3000"
                }
                 http={
                    port="80"
                }
                 https={
                    port="443"
                }
                elastic_search={
                  port="9200"
              }
              kibana={
                port="5601"
            }
               logstash={
                port="9600"
            }
                 beats={
                port="5044"
            }
                tcp_input={
                port="5000"
            }
                tool_input={
                port="9300"
            }
            prometheus={
              port="9090"
          }
            }
    }
    
}
dns={
  monitor
  grafana
}