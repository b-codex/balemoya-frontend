import React, { useEffect, useState } from "react";
import Sidebar from "../../components/Sidebar/Sidebar";
import Navbar from "../../components/Navbar/Navbar";
import "./Home.scss";
import Widget from "../../components/Widget/Widget.jsx";
import Featured from "../../components/Featured/Featured";
import Chart from "../../components/Chart/Chart";
import { Link } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { logout, selectUser } from "../../redux/userSlice";
import { useNavigate } from "react-router-dom";
import Snackbar from "@mui/material/Snackbar";
import IconButton from "@mui/material/IconButton";
import CloseIcon from "@mui/icons-material/Close";
import Stack from "@mui/material/Stack";
import MuiAlert from "@mui/material/Alert";
import { Button } from "antd";
import { getUsers, viewReports } from "../../utils/customer";
import { getJobs } from "../../utils/job";

const Home = (props) => {
  const Alert = React.forwardRef(function Alert(props, ref) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
  });
  const [open, setOpen] = React.useState(false);
  const handleClick = () => {
    setOpen(true);
  };

  const handleClose = (event, reason) => {
    if (reason === "clickaway") {
      return;
    }
    setOpen(false);
  };
  const action = (
    <React.Fragment>
      <Button color="secondary" size="small" onClick={handleClose}>
        OK
      </Button>
      <IconButton
        size="small"
        aria-label="close"
        color="inherit"
        onClick={handleClose}
      >
        <CloseIcon fontSize="small" />
      </IconButton>
    </React.Fragment>
  );

  const dispatch = useDispatch();
  const user = useSelector(selectUser);
  let navigate = useNavigate();

  const [users, setUsers] = useState([]);
  const [err, setErr] = useState("");
  const [jobs, setJobs] = useState([]);
  const [reports, setReports] = useState([]);
  useEffect(() => {
    if (user == null) {
      dispatch(logout());
      navigate(`/login`);
    } else {
      handleClick();
    }
  }, []);
  useEffect(() => {
    getUsers()
      .then((res) => res.json())
      .then((data) => {
        setUsers(data);
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
    getJobs()
      .then((res) => res.json())
      .then((data) => {
        setJobs(data);
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
    viewReports()
      .then((res) => res.json())
      .then((data) => {
        setReports(data);
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
  }, []);

  return (
    <div className="home">
      <Sidebar />
      <div className="home_container">
        <Navbar />
        <div className="widgets">
          <Link
            className="links"
            to="/users"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <Widget type="user" value={users.length} />
          </Link>

          <Link
            className="links"
            to="/reports"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <Widget type="reports" value={reports.length} />
          </Link>
          <Link
            className="links"
            to="/jobs"
            style={{ textDecoration: "none", color: "inherit" }}
          >
            <Widget type="job post" value={jobs.length} />
          </Link>
        </div>
        <div className="charts">
          <Featured />
          <Chart />
          <Snackbar open={open} autoHideDuration={3000} onClose={handleClose}>
            <Alert
              onClose={handleClose}
              severity="success"
              sx={{ width: "100%" }}
            >
              Login Successful!
            </Alert>
          </Snackbar>
        </div>
      </div>
    </div>
  );
};

export default Home;
