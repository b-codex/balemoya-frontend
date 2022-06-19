import { React, useEffect, useState } from "react";

import "./ReportList.scss";

import Sidebar from "../../components/Sidebar/Sidebar";
import Navbar from "../../components/Navbar/Navbar";
import Datatable from "../../components/Datatables/Datatable";

import { Link } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { logout, selectUser } from "../../redux/userSlice";
import { useNavigate } from "react-router-dom";
import { JobReportsListToolbar } from "../../components/jobReports/JobReportsListToolbar";
import { JobReportsListResult } from "../../components/jobReports/JobReportsListResult";
import { Box, Container } from "@mui/material";
import { getJobs } from "../../utils/job";
import { viewReports } from "../../utils/customer";


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

  const [reports, setReports] = useState([]);
  const [err, setErr] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  const [reportLength, setReportLength] = useState("");

  useEffect(() => {
    viewReports(user.token)
      .then((res) => res.json())
      .then((data) => {
        setReports(data);
        setReportLength(data["report"].length);
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
  }, []);

  // const jobss = reports["report"]?.[0];
  // console.log(reports["report"]?.[0]['reportee']);
  // console.log(reports["report"]?.[0]);

  const setLengthBool = () => {
    if (reportLength >= "0") {
      return true;
    }
    return false;
  };

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
          <Container maxWidth={false}>
            <JobReportsListToolbar
              name="Reported Accounts"
              setSearchTerm={setSearchTerm}
            />
            <Box sx={{ mt: 3 }}>
              {setLengthBool ? (
                <JobReportsListResult
                  jobs={reports}
                  searchTerm={searchTerm}
                />
              ) : (
                <div className="no_reports">No reports were found</div>
              )}
            </Box>
          </Container>
        </Box>
        {/* <Datatable /> */}
      </div>
    </div>
  );
};

export default JobList;
