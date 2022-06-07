import {
  Avatar,
  Box,
  Button,
  Card,
  CardActions,
  CardContent,
  Divider,
  Typography,
} from "@mui/material";
import { getJobs, getJobsById, deleteJobsById } from "../../utils/jobs";
import { useParams } from "react-router";
import { useSelector } from "react-redux";
import { useState } from "react";
import { selectUser } from "../../redux/userSlice";

export const JobProfile = (props) => {
  let { userId } = useParams();
  const user = useSelector(selectUser);
  const [userData, setUserData] = useState(null);
  const [err, setErr] = useState("");

  return (
    <Card {...props}>
      <CardContent>
        <Box
          sx={{
            alignItems: "center",
            display: "flex",
            flexDirection: "column",
          }}
        >
          <Typography color="textPrimary" gutterBottom variant="h5">
            {props.user?.jobTitle}
          </Typography>
          <Typography color="textSecondary" variant="body2">
            Posted By: {props.user?.postedBy}
          </Typography>
          <Typography color="textSecondary" variant="body2">
            Company Name: {props.user?.companyName}
          </Typography>
        </Box>
      </CardContent>
      <Divider />
      <CardActions>
        {props.user?.status ? (
          <Button
            color="error"
            fullWidth
            variant="text"
            // onClick={banUsersById}
          >
            Ban Post
          </Button>
        ) : (
          <Button
            color="warning"
            fullWidth
            variant="text"
            // onClick={unbanUsersById}
          >
            Unban Post
          </Button>
        )}
      </CardActions>
    </Card>
  );
};
