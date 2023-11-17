// SPDX-License-Identifier: MIT
pragma solidity ^0.5.12;
contract Election {

                    address public Admin;
                    uint256 TotalCandidates;
                    

                    constructor() public {
                                             Admin = msg.sender;
                                         }

                    modifier onlyAdmin() {
                                            require(msg.sender == Admin,"Only Admin is allowed" );
                        _;               }

                    modifier onlyVerifiedVoter() {
                                                   require(VerifiedVoters[msg.sender], "Only Verified Voter is allowed");
                        _;                       }
                    
                    struct Candidate {
                                        uint256 CandidateId;
                                        string CandidateName;
                                        string Proposal;
                                        address CandidateAddress;
                                        uint256 Count;
                                    }

                    struct Voter {
                                    string VoterName;
                                    address VoterAddress;
                                    uint256 VoterId;
                                }

                    mapping(uint256 => Candidate) Candidates;
                    mapping(uint256 => Voter) Voters;
                    mapping(address => bool) AlreadyVoted;
                    mapping(address => bool) TransferedVote;
                    mapping(address => address) delegates;
                    mapping(address => bool) VerifiedVoters;
                
                    function addVoter(uint256 _VoterId, string memory _VoterName,address _VoterAddress)
                     public onlyAdmin {

                                        require(ElectionStatus!=1,"Election is going on");

                                        Voters[_VoterId].VoterAddress = _VoterAddress;
                                        Voters[_VoterId].VoterName = _VoterName;
                                        Voters[_VoterId].VoterId = _VoterId;
                                        VerifiedVoters[_VoterAddress] = true;
                                       }
                    
                    function addCandidate(uint256 _CandidateId, string memory _CandidateName,
                                          string memory _Proposal, address _CandidateAddress )
                     public onlyAdmin {
                            
                                        require(ElectionStatus!=1,"Election is going on"); 

                                        Candidates[_CandidateId].CandidateAddress = _CandidateAddress;
                                        Candidates[_CandidateId].CandidateName = _CandidateName;
                                        Candidates[_CandidateId].Proposal = _Proposal;
                                        Candidates[_CandidateId].CandidateId = _CandidateId;
                                        TotalCandidates++;
                                      }

                    uint256 ElectionStatus;
                    function StartElection() public onlyAdmin 
                                    {
                                        require(ElectionStatus == 0, "Election has already started");
                                        ElectionStatus = 1;
                                    }
                            
                    function EndElection() public onlyAdmin 
                                    {
                                        require(ElectionStatus == 1, "Election has not yet started");
                                        ElectionStatus = 0;
                                    }
                    
                    function GetVoterDetails (uint256 _VoterId)      
                        public view returns (string memory VoterName, address VoterAddress)
                                    {
                              return (Voters[_VoterId].VoterName , Voters[_VoterId].VoterAddress );      
                                    }

                    function GetCandidateDetails (uint256 _CandidateId)
                        public view returns (string memory CandidateName, string memory Proposal)
                                    {
                             return (Candidates[_CandidateId].CandidateName, Candidates[_CandidateId].Proposal);
                                    }
                
                    function CastVote(uint256 _CandidateId)
                        public onlyVerifiedVoter 
                                    {
                                        require(ElectionStatus==1,"Election is not going on");
                                        require(!AlreadyVoted[msg.sender],"You have already Voted");
                                        require(!TransferedVote[msg.sender],"You have already Transfered your Vote");
                                        AlreadyVoted[msg.sender] = true;
                                        Candidates[_CandidateId].Count=Candidates[_CandidateId].Count+1;   
                                        
                                    }

                    function GetVoteResults(uint256 _CandidateId) 
                        public view returns (uint256 CandidateId, string memory CandidateName, uint256 Count )
                                   {
                                         require(ElectionStatus==0,"Election is going on");
                             return (Candidates[_CandidateId].CandidateId, Candidates[_CandidateId].CandidateName, Candidates[_CandidateId].Count);
                                   }

                    function delegateVote(address _delegate)
                        public {
                                require(msg.sender != _delegate, "Self-delegation is not allowed");
                                require(msg.sender!=Admin,"Admin can not Vote");
                                require(!TransferedVote[msg.sender],"You have already Transfered your Vote");
                                        TransferedVote[msg.sender] = true;
                                        delegates[msg.sender] = _delegate;
                                }

                    function castDelegatedVote(uint256 _CandidateId) 
                        public {
                                require(ElectionStatus==1,"Election is not going on");
                                require(msg.sender!=Admin,"Admin can not Vote");
                                require(!TransferedVote[msg.sender],"You have already Transfered your Vote");
                                address delegate = delegates[msg.sender];
                                require(!AlreadyVoted[delegate], "Delegate has already voted");
                                Candidates[_CandidateId].Count = Candidates[_CandidateId].Count + 1;
                                AlreadyVoted[msg.sender] = true;
                                }

                    function getWinner() public view returns (string memory, uint256)
                                        {
                                            require(ElectionStatus==0,"Election is going on");
                                                uint256 MaxVotes = 0;
                                                string memory WinnerName;
                                                            
                        for (uint256 i = 0; i <= TotalCandidates; i++) 
                           {
                            if (Candidates[i].Count > MaxVotes)                        
                                        {
                                            MaxVotes = Candidates[i].Count;             
                                            WinnerName = Candidates[i].CandidateName;
                                        }
                           }
                              return (WinnerName, MaxVotes);
                                        }
                }