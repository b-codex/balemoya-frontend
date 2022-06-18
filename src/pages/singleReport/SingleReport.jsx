import React, { useEffect, useState } from "react";
import Navbar from "../../components/Navbar/Navbar";
import Sidebar from "../../components/Sidebar/Sidebar";
import "../../style/global.scss";
import moment from "moment";
import {
  Box,
  Card,
  CardContent,
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
          </Container>
        </Box>
      </div>
    </div>
  );
};

export default Single;
