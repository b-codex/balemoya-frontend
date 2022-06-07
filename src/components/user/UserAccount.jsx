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
import { banUsersById, unbanUsersById } from "../../utils/customer";
import { useParams } from "react-router";
import { useSelector } from "react-redux";
import { useState } from "react";
import { selectUser } from "../../redux/userSlice";

export const UserProfile = (props) => {
  let { userId } = useParams();
  const user = useSelector(selectUser);
  const [userData, setUserData] = useState(null);
  const [err, setErr] = useState("");
  // const [users, setUsers] = useState("");

  // banUsersById(userId, user.token)
  //   .then((res) => res.json())
  //   .then((data) => {
  //     setUserData(data);
  //   })
  //   .catch((_) => {
  //     setErr("Something went wrong");
  //     console.log(err);
  //   });
  // unbanUsersById(userId, user.token)
  //   .then((res) => res.json())
  //   .then((data) => {
  //     setUserData(data);
  //   })
  //   .catch((_) => {
  //     setErr("Something went wrong");
  //     console.log(err);
  //   });

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
          <Avatar
            src={props.user?.profilePicture}
            sx={{
              height: 64,
              mb: 2,
              width: 64,
            }}
          />
          <Typography color="textPrimary" gutterBottom variant="h5">
            {props.user?.fullName}
          </Typography>
          <Typography color="textSecondary" variant="body2">
            Email: {props.user?.email}
          </Typography>
          <Typography color="textSecondary" variant="body2">
            Location: {props.user?.location}
          </Typography>
        </Box>
      </CardContent>
      <Divider />
      <CardActions>
        {props.user?._isUserActive ? (
          <Button color="error" fullWidth variant="text" 
          // onClick={banUsersById}
          >
            Ban User
          </Button>
        ) : (
          <Button
            color="warning"
            fullWidth
            variant="text"
            // onClick={unbanUsersById}
          >
            Unban User
          </Button>
        )}
      </CardActions>
    </Card>
  );
};
