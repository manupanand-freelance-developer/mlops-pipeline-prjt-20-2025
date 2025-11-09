env             ="dev"
zone_id         ="Z08142241SY16ZULZO1LU"
vpc_name        ="default_vpc_south2"
subnet_name     ="default-ap-south-2c"
ami_id          ="ami-0e86c549c4c958e98"
# fill details



ec2_instance={
   clickhouse={
        instance_type ="t3.large" #"r6i.large"
        volume_size   =30
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonS3ReadOnlyAccess"]
        server_port={
                ssh={
                    port="22"
                }
                tcp={
                    port="9000"
                }
                 http={
                    port="80"
                }
                 https={
                    port="443"
                }
                httpinterface={
                  port="8123"
                }
                httpsinterface={
                  port="8443"
                }
                SSL={
                  port="9010"
                }
                prometheus={
                  port="9363"
                }
                securessl={
                  port="9281"
                }
                
                zookeper={
                  port="2181"
                }
                mysql={
                  port="9004"
                }
                psql={
                  port="9005"
                }
                communi={
                  port="9009"
                }
                graphite={
                  port="42000"
                }
                native={
                  port="9440"
                }
                native2={
                  port="9011"
                }
                keeper={
                  port="9234"
                }
                keeper2={
                  port="9181"
                }
                grpc={
                  port="9100"
                }
                jdbcbridge={
                  port="9019"
                }
                
            }
    } 
}
dns={
  datalake="clickhouse"
  
}