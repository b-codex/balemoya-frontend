import { React, useEffect, useState } from "react";

import "./List.scss";

import Sidebar from "../../components/Sidebar/Sidebar";
import Navbar from "../../components/Navbar/Navbar";
import Datatable from "../../components/Datatables/Datatable";

import { Link } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { logout, selectUser } from "../../redux/userSlice";
import { useNavigate } from "react-router-dom";
import { UserListToolbar } from "../../components/user/UsersListToolbar";
import { UserListResults } from "../../components/user/UsersListResult";
import { Box, Container } from "@mui/material";
import { getUsers } from "../../utils/customer";

const List = () => {
  const dispatch = useDispatch();
  const user = useSelector(selectUser);
  let navigate = useNavigate();
  useEffect(() => {
    if (user == null) {
      dispatch(logout());
      navigate(`/login`);
    }
  }, []);

  const [users, setUsers] = useState([]);
  const [err, setErr] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  useEffect(() => {
    // add user tokens inside the param
    getUsers(user.token)
      .then((res) => res.json())
      .then((data) => {
        setUsers(data);
      })
      .catch((_) => {
        setErr("Something went wrong");
      });
  }, []);
  return (
    <div className="list">
      <Sidebar />
      <div className="list_container">
        <Navbar />
        <Box
          component="main"
          sx={{
            flexGrow: 1,
            py: 2,
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

export default List;
