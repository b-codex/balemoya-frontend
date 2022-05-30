export const userColumns = [
  { field: "_id", headerName: "ID", width: 240 },
  {
    field: "fullName",
    headerName: "User",
    width: 230,
  },
  {
    field: "email",
    headerName: "Email",
    width: 230,
  },
  {
    field: "role",
    headerName: "Role",
    width: 140,
  },
  {
    field: "verificationStatus",
    headerName: "Verification Status",
    width: 160,
    renderCell: (params) => {
      return (
        <div className={`cell_with_status ${params.row.status}`}>
          {params.row.verificationStatus == "verified"
            ? "Verified"
            : "Not Verified"}
        </div>
      );
    },
  },
];
