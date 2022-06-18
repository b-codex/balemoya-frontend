import React, { useState } from "react";
import PerfectScrollbar from "react-perfect-scrollbar";
import PropTypes from "prop-types";
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
import { deleteUsersById } from "../../utils/customer";
import Snackbar from "@mui/material/Snackbar";
import IconButton from "@mui/material/IconButton";
import CloseIcon from "@mui/icons-material/Close";
import MuiAlert from "@mui/material/Alert";
import { Button } from "antd";
import "./UsersListResult.scss";

export const UserListResults = ({ customers, searchTerm, ...rest }) => {
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
  if (user) {
    var token = user.accessToken;
  }
  const [selectedCustomerIds, setSelectedCustomerIds] = useState([]);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);
  const [err, setErr] = useState("");
  const [userData, setUserData] = useState(null);
  let navigate = useNavigate();

  const handleSelectAll = (event) => {
    let newSelectedCustomerIds;

    if (event.target.checked) {
      newSelectedCustomerIds = customers.map((customer) => customer._id);
    } else {
      newSelectedCustomerIds = [];
    }

    setSelectedCustomerIds(newSelectedCustomerIds);
  };

  const handleSelectOne = (event, id) => {
    const selectedIndex = selectedCustomerIds.indexOf(id);
    let newSelectedCustomerIds = [];

    if (selectedIndex === -1) {
      newSelectedCustomerIds = newSelectedCustomerIds.concat(
        selectedCustomerIds,
        id
      );
    } else if (selectedIndex === 0) {
      newSelectedCustomerIds = newSelectedCustomerIds.concat(
        selectedCustomerIds.slice(1)
      );
    } else if (selectedIndex === selectedCustomerIds.length - 1) {
      newSelectedCustomerIds = newSelectedCustomerIds.concat(
        selectedCustomerIds.slice(0, -1)
      );
    } else if (selectedIndex > 0) {
      newSelectedCustomerIds = newSelectedCustomerIds.concat(
        selectedCustomerIds.slice(0, selectedIndex),
        selectedCustomerIds.slice(selectedIndex + 1)
      );
    }

    setSelectedCustomerIds(newSelectedCustomerIds);
  };

  const handleLimitChange = (event) => {
    setLimit(event.target.value);
  };

  const handlePageChange = (event, newPage) => {
    setPage(newPage);
  };

  const handleDelete = (id) => {
    try {
      deleteUsersById(id, user.token)
        .then((res) => res.json())
        .then((data) => {
          setUserData(data);
          window.location.reload();
          handleClick();
        })
        .catch((_) => {
          setErr("Something went wrong");
        });
    } catch (error) {}
  };

  return (
    <Card {...rest}>
      <PerfectScrollbar>
        <Box sx={{ minWidth: 1050 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell padding="checkbox">
                  <Checkbox
                    checked={selectedCustomerIds.length === customers.length}
                    color="primary"
                    indeterminate={
                      selectedCustomerIds.length > 0 &&
                      selectedCustomerIds.length < customers.length
                    }
                    onChange={handleSelectAll}
                  />
                </TableCell>
                <TableCell>Name</TableCell>
                <TableCell>Email</TableCell>
                <TableCell>Location</TableCell>
                <TableCell>Role</TableCell>
                <TableCell>Verified</TableCell>
                <TableCell>Account Status</TableCell>
                <TableCell>Action</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {customers
                .slice(0, limit)
                .filter((val) => {
                  if (searchTerm == "") {
                    return val;
                  } else if (
                    val.fullName
                      .toLowerCase()
                      .includes(searchTerm.toLowerCase())
                  ) {
                    return val;
                  }
                })
                .map((customer) => (
                  <TableRow
                    hover
                    key={customer._id}
                    selected={selectedCustomerIds.indexOf(customer._id) !== -1}
                  >
                    <TableCell padding="checkbox">
                      <Checkbox
                        checked={
                          selectedCustomerIds.indexOf(customer._id) !== -1
                        }
                        onChange={(event) =>
                          handleSelectOne(event, customer._id)
                        }
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
                        {customer.profilePicture ? (
                          <Avatar
                            src={customer.profilePicture}
                            sx={{
                              backgroundPosition: "center",
                              mr: 2,
                              borderRadius: "50%",
                            }}
                          ></Avatar>
                        ) : (
                          <Avatar
                            // src={customer.avatarUrl}
                            sx={{
                              mr: 2,
                              backgroundColor: "#BB8D6F",
                              padding: "4px",
                            }}
                          >
                            {getInitials(customer.fullName)}
                          </Avatar>
                        )}
                        <Typography color="textPrimary" variant="body1">
                          {customer.fullName}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>{customer.email}</TableCell>
                    <TableCell
                      style={{ textTransform: "capitalize" }}
                    >{`${customer.location}`}</TableCell>
                    <TableCell style={{ textTransform: "capitalize" }}>
                      {customer.role}
                    </TableCell>
                    <TableCell>
                      {customer.verified ? (
                        <div className="status_verified">
                          <span>Yes</span>
                        </div>
                      ) : (
                        <div className="status_not_verified">
                          <span>No</span>
                        </div>
                      )}
                    </TableCell>{" "}
                    <TableCell>
                      {customer._isUserActive ? (
                        <div className="status_active">
                          <span>Active</span>
                        </div>
                      ) : (
                        <div className="status_banned">
                          <span>Banned</span>
                        </div>
                      )}
                    </TableCell>
                    {/* <TableCell>
                      {customer._isUserActive ? (
                        <Chip label="Active" color="success" />
                      ) : (
                        <Chip label="Banned" color="error" />
                      )}
                    </TableCell> */}
                    <TableCell>
                      <IconButton
                        color="info"
                        aria-label="more info"
                        component="span"
                        onClick={() => navigate(`/users/${customer._id}`)}
                      >
                        <MoreHorizSharp />
                      </IconButton>
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
                        onClick={() => handleDelete(customer._id)}
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
        count={customers.length}
        onPageChange={handlePageChange}
        onRowsPerPageChange={handleLimitChange}
        page={page}
        rowsPerPage={limit}
        rowsPerPageOptions={[5, 10, 25]}
      />{" "}
    </Card>
  );
};

UserListResults.propTypes = {
  customers: PropTypes.array.isRequired,
};
