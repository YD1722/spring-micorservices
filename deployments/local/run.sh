function set_profile() {
  export AWS_PROFILE=yd
  export AWS_REGION=ap-southeast-1
}

function spin_up_supporting_infra() {
  docker network create wierd_arts_network

  docker compose up -d
  docker compose -f compose.kc.yaml up -d
}

function build_ms() {
  chmod +x build.sh
  ./build.sh
}

function spin_up_ms() {
  docker compose -f compose.ms.yaml up -d
}

#set_profile
spin_up_supporting_infra
#build_ms
#spin_up_ms