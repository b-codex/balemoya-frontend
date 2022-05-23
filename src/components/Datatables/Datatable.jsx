import { useState, useEffect } from "react";
import { Link } from "react-router-dom";

import { DataGrid } from "@mui/x-data-grid";
import "./Datatable.scss";
import { userColumns } from "../../datatablesource";
import { getUsers } from "../../utils/userUtils";

const Datatable = () => {
  const [data, setData] = useState();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    getUsers()
      .then((res) => {
        let r = res.map((e, i) => Object.assign(e, e.id = i))
        setData(r );
      })
      .finally(() => setLoading(false));
  }, []);
  // const handleDelete = (id) => {
  //   setData(data.filter((item) => item.id !== id));
  // };
  const actionColumn = [
    {
      field: "action",
      headerName: "Action",
      width: 200,
      renderCell: (params) => {
        return (
          <div className="cell_action">
            <Link
              to="/users/single"
              style={{ textDecoration: "none", color: "inherit" }}
            >
              <div clasName="view_button">View</div>
            </Link>
            <div
              className="delete_button"
              // onClick={() => handleDelete(params.row.id)}
            >
              Delete
            </div>
          </div>
        );
      },
    },
  ];

  if (loading) return <h1>Loading...</h1>;

  return (
    <div className="datatable">
      <div className="datatable_title">
        Search Users
        <Link
          to="/users/new"
          style={{ textDecoration: "none" }}
          className="link"
        >
          Add New
        </Link>
      </div>
      <DataGrid
        className="datagrid"
        rows={data}
        columns={userColumns.concat(actionColumn)}
        pageSize={9}
        rowsPerPageOptions={[9]}
        checkboxSelection
      />
    </div>
  );
};

export default Datatable;
