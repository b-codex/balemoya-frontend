import React, { useEffect, useState } from "react";
import PerfectScrollbar from "react-perfect-scrollbar";
import PropTypes from "prop-types";
import "./JobReportsListResult.scss";
import { format } from "date-fns";
import {
  Avatar,
  Box,
  Card,
  Checkbox,
  Chip,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TablePagination,
  TableRow,
  Typography,
} from "@mui/material";
import { getInitials } from "../../utils/get-initials";
import {
  DeleteOutlined,
  DetailsSharp,
  MoreHorizSharp,
} from "@mui/icons-material";
import { useSelector } from "react-redux";
import { selectUser } from "../../redux/userSlice";
import { useNavigate } from "react-router";
import Snackbar from "@mui/material/Snackbar";
import IconButton from "@mui/material/IconButton";
import CloseIcon from "@mui/icons-material/Close";
import Stack from "@mui/material/Stack";
import MuiAlert from "@mui/material/Alert";
import { Button } from "antd";
import { deleteJobPostById } from "../../utils/job";
import moment from "moment";
import { getUsersById } from "../../utils/customer";
import { useParams } from "react-router";

export const JobReportsListResult = ({ jobs, searchTerm, ...rest }) => {
  // console.log(reports["report"]?.[0]['reportee']);
  const reportLength = jobs["report"]?.length;
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
  const user = useSelector(selectUser);
  // const router = useRouter();
  if (user) {
    var token = user.accessToken;
  }
  const [selectedJobIds, setSelectedJobIds] = useState([]);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);
  const [err, setErr] = useState("");
  const [jobData, setJobData] = useState(null);
  const [userData, setUserData] = useState(null);
  let { userId } = useParams();

  let navigate = useNavigate();

  const handleSelectAll = (event) => {
    let newSelectedJobIds;

    if (event.target.checked) {
      newSelectedJobIds = jobs["report"]?.map((job) => job._id);
    } else {
      newSelectedJobIds = [];
    }

    setSelectedJobIds(newSelectedJobIds);
  };

  const handleSelectOne = (event, id) => {
    const selectedIndex = selectedJobIds.indexOf(id);
    let newSelectedJobIds = [];

    if (selectedIndex === -1) {
      newSelectedJobIds = newSelectedJobIds.concat(selectedJobIds, id);
    } else if (selectedIndex === 0) {
      newSelectedJobIds = newSelectedJobIds.concat(selectedJobIds.slice(1));
    } else if (selectedIndex === selectedJobIds.length - 1) {
      newSelectedJobIds = newSelectedJobIds.concat(selectedJobIds.slice(0, -1));
    } else if (selectedIndex > 0) {
      newSelectedJobIds = newSelectedJobIds.concat(
        selectedJobIds.slice(0, selectedIndex),
        selectedJobIds.slice(selectedIndex + 1)
      );
    }

    setSelectedJobIds(newSelectedJobIds);
  };

  const handleLimitChange = (event) => {
    setLimit(event.target.value);
  };

  const handlePageChange = (event, newPage) => {
    setPage(newPage);
  };

  const handleDelete = (id) => {
    try {
      deleteJobPostById(id, user.token)
        .then((res) => res.json())
        .then((data) => {
          setJobData(data);
          window.location.reload();
          handleClick();
        })
        .catch((_) => {
          setErr("Something went wrong");
        });
    } catch (error) {}
  };

  // useEffect(() => {
  //   getUsersById(userId, user.token)
  //     .then((res) => res.json())
  //     .then((data) => {
  //       setUserData(data);
  //     })
  //     .catch((err) => {
  //       setErr("Something went wrong");
  //     });
  // }, [userId]);

  return (
    <Card {...rest}>
      <PerfectScrollbar>
        <Box sx={{ minWidth: 1050 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell padding="checkbox">
                  <Checkbox
                    checked={selectedJobIds.length === jobs["report"]?.length}
                    color="primary"
                    indeterminate={
                      selectedJobIds.length > 0 &&
                      selectedJobIds.length < jobs["report"]?.length
                    }
                    onChange={handleSelectAll}
                  />
                </TableCell>
                <TableCell>Reporter ID</TableCell>
                <TableCell>Reportee ID</TableCell>
                <TableCell>Report ID</TableCell>
                <TableCell>Report Status</TableCell>
                <TableCell>Report Created</TableCell>
                <TableCell>Reporter Details</TableCell>
                <TableCell>Reportee Details</TableCell>
                <TableCell>Action</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {jobs["report"]
                ?.slice(0, limit)
                .filter((val) => {
                  if (searchTerm == "") {
                    return val;
                  } else if (
                    val.jobTitle
                      .toLowerCase()
                      .includes(searchTerm.toLowerCase())
                  ) {
                    return val;
                  }
                })
                .map((job) => (
                  <TableRow
                    hover
                    key={job._id}
                    selected={selectedJobIds.indexOf(job._id) !== -1}
                  >
                    <TableCell padding="checkbox">
                      <Checkbox
                        checked={selectedJobIds.indexOf(job._id) !== -1}
                        onChange={(event) => handleSelectOne(event, job._id)}
                        value="true"
                      />
                    </TableCell>
                    <TableCell>
                      <Box
                        sx={{
                          alignItems: "center",
                          display: "flex",
                        }}
                      >
                        <Typography color="textPrimary" variant="body1">
                          {job.reporter}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>{job.reportee} </TableCell>
                    <TableCell>{job._id}</TableCell>
                    <TableCell>{job.reportStatus}</TableCell>
                    <TableCell>
                      {moment(job.createdAt).format("MM/DD/YYYY")}
                    </TableCell>
                    <TableCell>
                      <IconButton
                        color="info"
                        aria-label="more"
                        component="span"
                        sx={{
                          border: "none",
                          fontSize: "14px",
                          justifyContent: "start",
                        }}
                        // onClick={() => navigate(`/jobs/${job._id}`)}
                        onClick={() => navigate(`/users/${job.reporter}`)}
                      >
                        <div className="status_active">
                          <span>Reporter</span>
                        </div>
                      </IconButton>
                    </TableCell>{" "}
                    <TableCell>
                      <IconButton
                        color="info"
                        aria-label="more"
                        component="span"
                        sx={{
                          border: "none",
                          fontSize: "14px",
                          justifyContent: "start",
                        }}
                        // onClick={() => navigate(`/jobs/${job._id}`)}
                        onClick={() => navigate(`/users/${job.reportee}`)}
                      >
                        <div className="status_banned">
                          <span>Reportee</span>
                        </div>
                      </IconButton>
                    </TableCell>
                    <TableCell>
                      <Snackbar
                        open={open}
                        autoHideDuration={3000}
                        onClose={handleClose}
                      >
                        <Alert
                          onClose={handleClose}
                          severity="success"
                          sx={{ width: "100%", boxShadow: "none" }}
                        >
                          Entry Deleted Successfully!
                        </Alert>
                      </Snackbar>
                      <IconButton
                        color="error"
                        aria-label="delete user"
                        component="span"
                        onClick={() => handleDelete(job.reportee)}
                      >
                        <DeleteOutlined />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
            </TableBody>
          </Table>
        </Box>
      </PerfectScrollbar>
      <TablePagination
        component="div"
        count={jobs["report"]?.length}
        onPageChange={handlePageChange}
        onRowsPerPageChange={handleLimitChange}
        page={page}
        rowsPerPage={limit}
        rowsPerPageOptions={[5, 10, 25]}
      />
    </Card>
  );
};

JobReportsListResult.propTypes = {
  jobs: PropTypes.array.isRequired,
};
