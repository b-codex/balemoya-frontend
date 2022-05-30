import { Box, Container } from "@mui/material";
import React, { useEffect, useState } from "react";
import Datatable from "../../components/Datatables/Datatable";
import { UserListToolbar } from "../../components/user/UsersListToolbar";
import Navbar from "../../components/Navbar/Navbar";
import Sidebar from "../../components/Sidebar/Sidebar";
import "./JobList.scss";
import { useDispatch, useSelector } from "react-redux";
import { logout, selectUser } from "../../redux/userSlice";
import { useNavigate } from "react-router";
import { getUsers } from "../../utils/customer";
import { UserListResults } from "../../components/user/UsersListResult";

const JobList = () => {
  const dispatch = useDispatch();
  const user = useSelector(selectUser);
  let navigate = useNavigate();
  useEffect(() => {
    if (user == null) {
      dispatch(logout());
      navigate(`/login`);
    }
  }, []);

  const [users, setUsers] = useState([])
  const [err, setErr] = useState("")
  const [searchTerm, setSearchTerm] = useState("")

  useEffect(() => {
    // add user tokens inside the param
    getUsers()
      .then((res) => res.json())
      .then((data) => {
          setUsers(data);
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
  }, []);
  return (
    <div className="joblist">
      <Sidebar />
      <div className="job_container">
        <Navbar />
        <Box
        component="main"
        sx={{
          flexGrow: 1,
          py: 8,
        }}
      >
        <Container maxWidth={false}>
        <UserListToolbar name="Users" setSearchTerm={setSearchTerm} />
          <Box sx={{ mt: 3 }}>
            <UserListResults customers={users} searchTerm={searchTerm} />
          </Box>
        </Container>
      </Box>
      </div>
    </div>
  );
};

export default JobList;
