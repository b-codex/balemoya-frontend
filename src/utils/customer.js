export const getUsers = async () => {
  const response = await fetch(
    "http://localhost:5655/microservice/accountService/users/",
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
  return response;
};

export const getUsersById = async (id, token) => {
  const response = await fetch(
    "http://localhost:5655/microservice/accountService/users/" + id,
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
    "http://localhost:5655/microservice/accountService/admin/banning-user/",
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
    "http://localhost:5655/microservice/accountService/admin/unbanning-user/",
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
