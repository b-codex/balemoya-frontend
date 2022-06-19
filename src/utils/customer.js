export const getUsers = async (token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/admin/users",
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    }
  );

  return response;
};
export const getAdminProfile = async (token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/admin/profile",
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    }
  );
  return response;
};

export const getUsersById = async (id, token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/users/singleUser/" + id,

    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    }
  );
  return response;
};

export const banUsersById = async (id, token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/admin/banning-user/",
    {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },

      body: JSON.stringify({ id: id, _isUserActive: "false" }),
    }
  );
  return response;
};
export const unbanUsersById = async (id, token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/admin/unBanning-user/",
    {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },

      body: JSON.stringify({ id: id, _isUserActive: "true" }),
    }
  );
  return response;
};

export const deleteUsersById = async (id, token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/admin/delete/user",
    {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify({
        user: id,
      }),
    }
  );
  return response;
};

export const verifyUsersById = async (id, token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/admin/verifying-user/",
    {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },

      body: JSON.stringify({
        id: id,
        verified: "true",
      }),
    }
  );
  return response;
};
export const unverifyUsersById = async (id, token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/admin/UnVerifying-user",
    {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },

      body: JSON.stringify({
        id: id,
        verified: "false",
      }),
    }
  );
  return response;
};
export const viewReports = async (token) => {
  const response = await fetch(
    "http://localhost:8000/microservice/accountService/admin/profile",
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    }
  );
  return response;
};
