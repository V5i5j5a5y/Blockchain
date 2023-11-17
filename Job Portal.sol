// SPDX-License-Identifier: MIT
pragma solidity ^0.5.12;
contract JobPortalApp {
    address public Admin;
    constructor() public {
        Admin = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == Admin);
        _;
    }

    modifier onlyApplicant() {
        require(msg.sender != Admin);
        _;
    }

    struct Applicant {
        string name;
        string email;
        string ApplicantType;
        uint256 rating;
    }
    struct Job {
        string Designation;
        string Description;
        uint256 salary;
        uint256 JobCount;
               }

    mapping(uint256 => Applicant) Applicants;
    mapping(uint256 => Job) Jobs;
    

    function addApplicant(
        uint256 _Applicantid,
        string memory _name,
        string memory _email,
        string memory _ApplicantType ) public onlyOwner {
        Applicants[_Applicantid].name = _name;
        Applicants[_Applicantid].email = _email;
        Applicants[_Applicantid].ApplicantType = _ApplicantType;
        }
    
    function addJob(
        uint256 _Jobid,
        string memory _Designation,
        string memory _Description,
        uint256 _salary  ) public onlyOwner {
        Jobs[_Jobid].Designation = _Designation;
        Jobs[_Jobid].Description = _Description;
        Jobs[_Jobid].salary = _salary;
        }
   
   
   function GetApplicantDetails(uint256 _Applicantid)
        public view returns (
            string memory name,
            string memory email,
            string memory ApplicantType
        )
    {
        return (
            Applicants[_Applicantid].name,
            Applicants[_Applicantid].email,
            Applicants[_Applicantid].ApplicantType
               );
    }


    function GetJobDetails(uint256 _Jobid)
        public view returns (
            string memory Designation,
            string memory Description,
            uint256 salary
        )
    {
        return (
            Jobs[_Jobid].Designation,
            Jobs[_Jobid].Description,
            Jobs[_Jobid].salary
               );
    }
    function ApplyForJob(uint256 _Jobid)
        public onlyApplicant {
          Jobs[_Jobid].JobCount=Jobs[_Jobid].JobCount+1;
        }
    function AddRating(uint256 _Applicantid, uint256 _rating)
        public onlyOwner {
            require(_rating >0 && _rating <=5);
           Applicants[_Applicantid].rating = _rating;
        }
    function GetRating(uint256 _Applicantid) 
    public view returns(uint256 rating)
    {
        return (Applicants[_Applicantid].rating);
    }
    function GetJobCount(uint256 _Jobid) 
    public view returns(uint256 JobCount)
    {
        return (Jobs[_Jobid].JobCount);
    }
}