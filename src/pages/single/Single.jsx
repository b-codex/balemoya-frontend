import React, { useEffect, useState } from "react";
import Navbar from "../../components/Navbar/Navbar";
import Sidebar from "../../components/Sidebar/Sidebar";
import "../../style/global.scss";
import moment from "moment";
import { Box, Card, CardContent, Container, Grid, Typography } from "@mui/material";
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
        setUserData(data)
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
          py: 8,
        }}
      >
        <Container maxWidth="lg">
          <Typography sx={{ mb: 3 }} variant="h4">
            Account
          </Typography>
          <Grid container spacing={3}>
            <Grid item lg={6} md={6} xs={12}>
              <UserProfile user={userData} />
            </Grid>
            <Grid item lg={6} md={6} xs={12}>
              <Card>
                <CardContent>
                  <Box
                    sx={{
                      alignItems: "center",
                      display: "flex",
                      flexDirection: "column",
                    }}
                  >
                    <Typography color="textPrimary" gutterBottom variant="h5">
                      Essay
                    </Typography>
                    <Typography color="textSecondary" variant="body2">
                      {userData?.essay}
                    </Typography>
                  </Box>
                </CardContent>
              </Card>
              <br></br>
              <Card>
                <CardContent>
                  <Box
                    sx={{
                      alignItems: "center",
                      display: "flex",
                      flexDirection: "column",
                    }}
                  >
                    <Typography color="textPrimary" gutterBottom variant="h5">
                      Bank Information
                    </Typography>
                    <Typography color="textSecondary" variant="body2">
                      Preferred Bank: {userData?.preferredBank}
                    </Typography>
                    <Typography color="textSecondary" variant="body2">
                      Account Number: {userData?.bankAccountNo}
                    </Typography>
                  </Box>
                </CardContent>
              </Card>
              <br></br>

              <Card>
                <CardContent>
                  <Box
                    sx={{
                      alignItems: "center",
                      display: "flex",
                      flexDirection: "column",
                    }}
                  >
                    <Typography color="textPrimary" gutterBottom variant="h5">
                      Contact's Information
                    </Typography>
                    <Typography color="textSecondary" variant="body2">
                      Contact's Name: {userData?.contactName}
                    </Typography>
                    <Typography color="textSecondary" variant="body2">
                      Contact's Phone Number: {userData?.contactPhone1}
                    </Typography>
                    <Typography color="textSecondary" variant="body2">
                      Contact's Other Phone No.:{userData?.contactPhone2}
                    </Typography>
                    <Typography color="textSecondary" variant="body2">
                      Contact's Email: {userData?.contactEmail}
                    </Typography>
                  </Box>
                </CardContent>
              </Card>
            </Grid>
          </Grid>
          <Typography sx={{ mb: 3 }} variant="h4">
            Reports
          </Typography>
          {/* <Grid container spacing={3}>
            {userData?.reports.map((report, index) => {
              return (
                <Grid item lg={6} md={6} xs={12} key={index}>
                  <Card>
                    <CardContent>
                      <Box
                        sx={{
                          alignItems: "center",
                          display: "flex",
                          flexDirection: "column",
                        }}
                      >
                        <Typography color="textPrimary" gutterBottom variant="h5">
                          Report {index + 1} - {moment(report.reportdate).format("MM/DD/YYYY")}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Professionality: {report.professionality}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Total Hour Tutored: {report.semiTotalHour}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          No. of Days: {report.noDays}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Tutored Subjects: {report.subjects.toString()}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Covered Topics: {report.topics}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Enviromental Challenge: {report.envChallenge}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Enviromental Response: {report.envResponse}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Enviromental Help: {report.envHelp}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Enviromental Challenge: {report.envChallenge}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Enviromental Response: {report.envResponse}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Enviromental Help: {report.envHelp}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Tutee Challenge: {report.tuteeChallenge}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Tutee Response: {report.tuteeResponse}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Tutee Help: {report.tuteeHelp}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Your Challenge: {report.yourChallenge}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Your Response: {report.yourResponse}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Your Help: {report.yourHelp}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Feedback: {report.feedback}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Feedback: {report.feedback}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Quiz: {report.quiz}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Assignment: {report.assg}
                        </Typography>
                        <Typography color="textSecondary" variant="body2">
                          Test: {report.test}
                        </Typography>
                      </Box>
                    </CardContent>
                  </Card>
                </Grid>
              );
            })}
          </Grid> */}
        </Container>
      </Box>
      </div>
    </div>
  );
};

export default Single;
