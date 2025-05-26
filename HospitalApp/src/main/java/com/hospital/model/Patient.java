package com.hospital.model;

public class Patient {
    private String name;
    private int age;
    private String gender;
    private String admissionDate;
    private String ailment;
    private String doctor;

    // Constructor
    public Patient(String name, int age, String gender, String admissionDate, String ailment, String doctor) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.admissionDate = admissionDate;
        this.ailment = ailment;
        this.doctor = doctor;
    }

    // Getters
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getGender() { return gender; }
    public String getAdmissionDate() { return admissionDate; }
    public String getAilment() { return ailment; }
    public String getDoctor() { return doctor; }
}
