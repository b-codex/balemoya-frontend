import React, { useEffect, useState } from "react";
import Navbar from "../../components/Navbar/Navbar";
import Sidebar from "../../components/Sidebar/Sidebar";
import "../../style/global.scss";
import moment from "moment";
import {
  Box,
  Card,
  CardContent,
  Chip,
  Container,
  Grid,
  Typography,
} from "@mui/material";
import { useParams } from "react-router";
import { useSelector } from "react-redux";
import { selectUser } from "../../redux/userSlice";
import { getJobsById } from "../../utils/job";
import { getUsersById } from "../../utils/customer";
const SingleJob = () => {
  // const { tid } = router.query;
  let { jobId } = useParams();
  const user = useSelector(selectUser);
  const [jobData, setJobData] = useState(null);
  const [err, setErr] = useState("");
  const [userData, setUserData] = useState(null);
  useEffect(
    () => {
      getJobsById(jobId)
        .then((res) => res.json())
        .then((data) => {
          setJobData(data);
        })
        .catch((err) => {
          setErr("Something went wrong");
        });
    },

    // getUsersById(jobData?.postedBy, user.token)
    //   .then((res) => res.json())
    //   .then((data) => {
    //     setUserData(data);
    //   })
    //   .catch((err) => {
    //     setErr("Something went wrong");
    //   })
    [jobId]
  );

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
          <Container maxWidth="lg">
            <Typography sx={{ mb: 3 }} variant="h4">
              Detailed Information
            </Typography>
            <Grid container spacing={4}>
              <Grid item lg={5} md={5} xs={10}>
                <Card>
                  <CardContent>
                    <Box
                      sx={{
                        alignItems: "left",
                        marginLeft: "45px",
                        display: "flex",
                        flexDirection: "column",
                        lineHeight: "54px",
                      }}
                    >
                      <Typography color="textPrimary" gutterBottom variant="h5">
                        Job Information
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Job Title</strong>: {jobData?.jobTitle}
                      </Typography>{" "}
                      <Typography color="textSecondary" variant="body2">
                        <strong>Job ID</strong>: {jobData?._id}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Job Type</strong>: {jobData?.jobType}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Job Tag(s)</strong>: {jobData?.tag}
                      </Typography>{" "}
                      <Typography color="textSecondary" variant="body2">
                        <strong>Post Created At</strong>: &nbsp;
                        {moment(jobData?.createdAt).format("MM/DD/YYYY")}
                      </Typography>{" "}
                      <Typography color="textSecondary" variant="body2">
                        <strong>Post Last Updated At</strong>: &nbsp;
                        {moment(jobData?.updatedAt).format("MM/DD/YYYY")}
                      </Typography>
                      {/* <Typography color="textSecondary" variant="body2">
                        <strong>Qualification</strong>: {jobData?.qualification}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Requirements</strong>: {jobData?.requirements}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Description</strong>: {jobData?.description}
                      </Typography> */}
                    </Box>
                  </CardContent>
                </Card>
                <br></br>
                <Card>
                  <CardContent>
                    <Box
                      sx={{
                        alignItems: "left",
                        display: "flex",
                        marginLeft: "45px",

                        flexDirection: "column",
                      }}
                    >
                      <Typography color="textPrimary" gutterBottom variant="h5">
                        Company Account Information
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Posted By</strong>: {userData?.fullName}
                      </Typography>{" "}
                      <Typography color="textSecondary" variant="body2">
                        <strong>Account ID</strong>: {jobData?.postedBy}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Company</strong>: {jobData?.companyName}
                      </Typography>
                      <Typography
                        color="textSecondary"
                        variant="body2"
                        style={{ textTransform: "capitalize" }}
                      >
                        <strong>Location</strong>: {jobData?.location}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Account Created At</strong>: &nbsp;
                        {moment(jobData?.createdAt).format("MM/DD/YYYY")}
                      </Typography>
                    </Box>
                  </CardContent>
                </Card>
                <br></br>
              </Grid>
            </Grid>
            <Typography sx={{ mb: 1 }} variant="h5">
              Reports
            </Typography>
            <Typography color="textSecondary" variant="body2">
              <strong>Total number of report(s) associated with this post</strong>: &nbsp;
              {userData?.report_Id ? userData?.report_Id.length : 'No Reports'}
            </Typography>
          </Container>
        </Box>
      </div>
    </div>
  );
};

export default SingleJob;
