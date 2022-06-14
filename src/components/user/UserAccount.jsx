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
import {
  banUsersById,
  deleteUsersById,
  unbanUsersById,
  unverifyUsersById,
  verifyUsersById,
} from "../../utils/customer";
import { Navigate, useParams } from "react-router";
import { useSelector } from "react-redux";
import { useState } from "react";
import { selectUser } from "../../redux/userSlice";
import { useNavigate } from "react-router";
import background from "./verified.png";

export const UserProfile = (props) => {
  let { userId } = useParams();
  let navigate = useNavigate();
  const user = useSelector(selectUser);
  const [userData, setUserData] = useState(null);
  const [err, setErr] = useState("");
  const [users, setUsers] = useState("");

  const handleBan = (id) => {
    try {
      banUsersById(id, user.token)
        .then((res) => res.json())
        .then((data) => {
          setUserData(data);
          window.location.reload();
        })
        .catch((_) => {
          setErr("Something went wrong");
        });
    } catch (error) {}
  };
  const handleUnBan = (id) => {
    try {
      unbanUsersById(id, user.token)
        .then((res) => res.json())
        .then((data) => {
          setUserData(data);
          window.location.reload();
        })
        .catch((_) => {
          setErr("Something went wrong");
        });
    } catch (error) {}
  };
  const handleDelete = (id) => {
    try {
      deleteUsersById(id, user.token)
        .then((res) => res.json())
        .then((data) => {
          setUserData(data);
          navigate(`/users/`);
        })
        .catch((_) => {
          setErr("Something went wrong");
        });
    } catch (error) {}
  };
  const handleVerification = (id) => {
    try {
      verifyUsersById(id, user.token)
        .then((res) => res.json())
        .then((data) => {
          setUserData(data);
          window.location.reload();
        })
        .catch((_) => {
          setErr("Something went wrong");
        });
    } catch (error) {}
  };
  const handleUnverification = (id) => {
    try {
      unverifyUsersById(id, user.token)
        .then((res) => res.json())
        .then((data) => {
          setUserData(data);
          window.location.reload();
        })
        .catch((_) => {
          setErr("Something went wrong");
        });
    } catch (error) {}
  };

  return (
    <Card {...props}>
      <CardContent>
        <Box
          sx={{
            alignItems: "left",
            marginLeft: "45px",
            display: "flex",
            flexDirection: "row",
            justifyContent: "space-around",
          }}
        >
          <Avatar
            src={props.user?.profilePicture}
            sx={{
              height: 224,
              mb: 2,
              width: 224,
              borderRadius: "8px",
            }}
          />
          <div style={{ alignSelf: "start", marginTop: "3vh" }}>
            <Typography
              color="textPrimary"
              gutterBottom
              variant="h4"
              style={{ display: "flex", textTransform: 'capitalize' }}
            >
              <span className="fullname">{props.user?.fullName}</span>
              {props.user?.verified ? (
                <div
                  className="empty"
                  style={{  backgroundImage: `url(${background})`, width: '25px', height: '25px', backgroundSize: 'contain', alignSelf: 'center', justifySelf: 'center'  }}
                  
                ></div>
              ) : (
                <div className="empty"></div>
              )}
            </Typography>
            <Typography color="textSecondary" variant="body2">
              Email: {props.user?.email}
            </Typography>
            <Typography
              color="textSecondary"
              variant="body2"
              style={{ textTransform: "capitalize", marginBottom: "2%" }}
            >
              Location: {props.user?.location}
            </Typography>
          </div>
        </Box>
      </CardContent>
      <Divider />
      <CardActions>
        {props.user?.verified ? (
          <Button
            color="warning"
            fullWidth
            variant="text"
            onClick={() => {
              handleUnverification(props.user._id);
            }}
          >
            Revoke Verification
          </Button>
        ) : (
          <Button
            color="primary"
            fullWidth
            variant="text"
            onClick={() => {
              handleVerification(props.user._id);
            }}
          >
            Verify Account
          </Button>
        )}
        {props.user?._isUserActive ? (
          <Button
            color="warning"
            fullWidth
            variant="text"
            onClick={() => {
              handleBan(props.user._id);
            }}
          >
            Ban User
          </Button>
        ) : (
          <Button
            color="warning"
            fullWidth
            variant="text"
            onClick={() => {
              handleUnBan(props.user._id);
            }}
          >
            Unban User
          </Button>
        )}
        <Button
          color="error"
          fullWidth
          variant="text"
          onClick={() => {
            handleDelete(props.user._id);
          }}
        >
          Delete Account
        </Button>
      </CardActions>
    </Card>
  );
};
