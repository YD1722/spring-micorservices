//package com.example.gateway.config;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.cloud.gateway.filter.factory.TokenRelayGatewayFilterFactory;
//import org.springframework.cloud.gateway.route.RouteLocator;
//import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//@Configuration
//public class RouteConfigs {
//    @Autowired
//    private TokenRelayGatewayFilterFactory filterFactory;
//
//    @Bean
//    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
//        return builder.routes()
//                .route("image-service", r -> r.path("/image/**")
//                        .filters(f -> f.filter(filterFactory.apply()))
//                        .uri("lb://IMAGE-SERVICE"))
//                .build();
//    }
//}
