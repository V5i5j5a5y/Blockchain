// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalRecords {
    struct Doctor {
        address doctorAddress;
        uint256 id;
        string name;
        string qualification;
        string workPlace;
    }

    struct Patient {
        address patientAddress;
        uint256 id;
        string name;
        uint256 age;
        string disease;
    }

    struct Medicine {
        uint256 id;
        string name;
        string expiryDate;
        string dose;
        uint256 price;
    }

    mapping(uint256 => Doctor) doctors;
    mapping(address => Patient) patientsByAddress;
    mapping(uint256 => Medicine) medicines;
    mapping(address => bool) doctorAddresses;

    uint256 doctorCount;
    uint256 patientCount;
    uint256 medicineCount;

    modifier onlyDoctor() {
        require(doctorAddresses[msg.sender], "Only registered doctors can call this function");
        _;
    }

    modifier onlyPatient() {
        require(patientsByAddress[msg.sender].id > 0, "Patient not found");
        _;
    }

    function registerDoctor(
        uint256 _id,
        string memory _name,
        string memory _qualification,
        string memory _workPlace
    ) public {
        doctorCount++;
        doctors[_id] = Doctor({
            doctorAddress: msg.sender,
            id: _id,
            name: _name,
            qualification: _qualification,
            workPlace: _workPlace
        });

               doctorAddresses[msg.sender] = true;
    }

    function registerPatient(uint256 _id, string memory _name, uint256 _age) public {
        patientCount++;
        patientsByAddress[msg.sender] = Patient({
            patientAddress: msg.sender,
            id: _id,
            name: _name,
            age: _age,
            disease: ""
        });
    }

    function addPatientDisease(string memory _disease) public onlyPatient {
        patientsByAddress[msg.sender].disease = _disease;
    }

    function addMedicine(
        uint256 _id,
        string memory _name,
        string memory _expiryDate,
        string memory _dose,
        uint256 _price
    ) public {
        medicineCount++;
        medicines[_id] = Medicine({
            id: _id,
            name: _name,
            expiryDate: _expiryDate,
            dose: _dose,
            price: _price
        });
    }

    function prescribeMedicine(address _patientAddress, uint256 _medicineId) public onlyDoctor {
        patientsByAddress[_patientAddress].disease = medicines[_medicineId].name;
    }

    function updatePatientAge(uint256 _age) public onlyPatient {
        patientsByAddress[msg.sender].age = _age;
    }

    function viewPatientData()
        public
        view
        onlyPatient
        returns (uint256, string memory, uint256, string memory)
    {
        Patient memory patient = patientsByAddress[msg.sender];
        return (patient.id, patient.name, patient.age, patient.disease);
    }

    function viewMedicineDetails(uint256 _id)
        public
        view
        returns (string memory, string memory, string memory, uint256)
    {
        Medicine memory medicine = medicines[_id];
        return (medicine.name, medicine.expiryDate, medicine.dose, medicine.price);
    }

    function viewPrescribedMedicine() public view onlyPatient returns (uint256[] memory) {
        uint256[] memory prescribedMedicines = new uint256[](medicineCount);
        uint256 count;
        for (uint256 i = 1; i <= medicineCount; i++) {
            if (keccak256(abi.encodePacked(patientsByAddress[msg.sender].disease)) == keccak256(abi.encodePacked(medicines[i].name))) {
                prescribedMedicines[count] = medicines[i].id;
                count++;
            }
        }
        // Resize the array to remove any unused slots
        assembly {
            mstore(prescribedMedicines, count)
        }
        return prescribedMedicines;
    }

    function viewPatientDataByDoctor(address _patientAddress)
        public
        view
        onlyDoctor
        returns (uint256, string memory, uint256, string memory)
    {
        Patient memory patient = patientsByAddress[_patientAddress];
        return (patient.id, patient.name, patient.age, patient.disease);
    }

    function viewDoctorDetails(uint256 _doctorId)
        public
        view
        returns (string memory, string memory, string memory)
    {
        Doctor memory doctor = doctors[_doctorId];
        return (doctor.name, doctor.qualification, doctor.workPlace);
    }
}
