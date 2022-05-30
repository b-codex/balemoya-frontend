
  export const getUsers = async () => {
    const response = await fetch("http://localhost:5655/microservice/accountService/users/", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    });
    return response;
  };

  export const getUsersById = async (id, token) => {
    const response = await fetch("http://localhost:5655/microservice/accountService/users/"+id, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${token}`
      },
    });
    return response;
  };