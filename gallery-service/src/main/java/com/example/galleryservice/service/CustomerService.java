package com.example.galleryservice.service;

import com.example.galleryservice.models.Customer;
import com.example.galleryservice.respository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {
    @Autowired
    CustomerRepository customerRepository;
    public void createCustomer(Customer customer){
        customerRepository.save(customer);
    }
}
