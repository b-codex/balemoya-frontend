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
import { getUsersById } from "../../utils/customer";
import { UserProfile } from "../../components/user/UserAccount";
const Single = () => {
  // const { tid } = router.query;
  let { userId } = useParams();
  const user = useSelector(selectUser);
  const [userData, setUserData] = useState(null);
  const [err, setErr] = useState("");
  useEffect(() => {
    getUsersById(userId, user.token)
      .then((res) => res.json())
      .then((data) => {
        setUserData(data);
      })
      .catch((err) => {
        setErr("Something went wrong");
      });
  }, [userId]);
  return (
    <div className="list">
      <Sidebar />
      <div className="list_container">
        <Navbar />
        <Box
          component="main"
          sx={{
            flexGrow: 1,
            py: 3,
          }}
        >
          <Container maxWidth="lg">
            <Typography sx={{ mb: 4 }} variant="h4">
              Account
            </Typography>
            <Grid container spacing={3}>
              <Grid item lg={6} md={6} xs={12}>
                <UserProfile user={userData} />
              </Grid>
              <Grid item lg={5} md={5} xs={10}>
                <Card>
                  <CardContent>
                    <Box
                      sx={{
                        alignItems: "left",
                        marginLeft: "45px",
                        display: "flex",
                        flexDirection: "column",
                      }}
                    >
                      <Typography color="textPrimary" gutterBottom variant="h5">
                        User Information
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Full Name</strong>: {userData?.fullName}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Email</strong>: {userData?.email}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Location</strong>: {userData?.location}
                      </Typography>{" "}
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
                        Account Information
                      </Typography>
                      <Typography
                        color="textSecondary"
                        variant="body2"
                        style={{ textTransform: "capitalize" }}
                      >
                        <strong>Role</strong>: {userData?.role}
                      </Typography>{" "}
                      <Typography color="textSecondary" variant="body2">
                        <strong>Verification Status</strong>:
                        {userData?.verificationStatus === "verified" &&
                          "Verified"}
                        {userData?.verificationStatus === "Not_verified" &&
                          "Not Verified"}{" "}
                        {userData?.verificationStatus == null &&
                          "No Verification Data"}
                      </Typography>
                      <Typography color="textSecondary" variant="body2">
                        <strong>Account Created At</strong>: &nbsp;
                        {moment(userData?.createdAt).format("MM/DD/YYYY")}
                      </Typography>
                    </Box>
                  </CardContent>
                </Card>
                <br></br>
              </Grid>
            </Grid>
            <Typography sx={{ mb: 3 }} variant="h4">
              Reports
            </Typography>
            <Typography color="textSecondary" variant="body2">
              <strong>Report(s) associated with this account</strong>:
              {userData?.report_Id + " "}
            </Typography>
          </Container>
        </Box>
      </div>
    </div>
  );
};

export default Single;
