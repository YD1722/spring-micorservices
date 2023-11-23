function set_profile() {
  export AWS_PROFILE=yd
  export AWS_REGION=ap-southeast-1
}

function spin_up_supporting_infra() {
  docker compose up -d
}

function start_kafka() {
  docker compose -f kafka.compose.yaml up -d
}

stop_kafka() {
  docker compose -f kafka.compose.yaml down
}

function build_ms() {
  chmod +x build.sh
  ./build.sh
}

function spin_up_ms() {
  docker compose -f compose.ms.yaml up -d
}

#set_profile
#start_kafka
#spin_up_supporting_infra
#build_ms
#spin_up_ms
stop_kafka
