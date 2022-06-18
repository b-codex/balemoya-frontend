import { React, useEffect, useState } from "react";

import "./JobList.scss";

import Sidebar from "../../components/Sidebar/Sidebar";
import Navbar from "../../components/Navbar/Navbar";
import Datatable from "../../components/Datatables/Datatable";

import { Link } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { logout, selectUser } from "../../redux/userSlice";
import { useNavigate } from "react-router-dom";
import { JobListToolbar } from "../../components/jobs/JobListToolbar";
import { JobListResults } from "../../components/jobs/JobListResult";
import { Box, Container } from "@mui/material";
import { getJobs } from "../../utils/job";

const JobList = () => {
  const dispatch = useDispatch();
  const user = useSelector(selectUser);
  let navigate = useNavigate();
  useEffect(() => {
    if (user == null) {
      dispatch(logout());
      navigate(`/login`);
    }
  }, []);

  const [jobs, setJobs] = useState([]);
  const [err, setErr] = useState("");
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    // add user tokens inside the param
    getJobs()
      .then((res) => res.json())
      .then((data) => {
        setJobs(data);
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
  }, []);
 

  return (
    <div className="list">
      <Sidebar />
      <div className="list_container">
        <Navbar />
        <Box
          component="main"
          sx={{
            flexGrow: 1,
            py: 2,
          }}
        >
          <Container  maxWidth={false}>
            <JobListToolbar name="Jobs" setSearchTerm={setSearchTerm} />
            <Box sx={{ mt: 3 }}>
              <JobListResults jobs={jobs} searchTerm={searchTerm} />
            </Box>
          </Container>
        </Box>
        {/* <Datatable /> */}
      </div>
    </div>
  );
};

export default JobList;
