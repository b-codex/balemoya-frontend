export const getJobs = async () => {
  const response = await fetch(
    "http://localhost:5655/microservice/jobService/employer/jobPost/",
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
  return response;
};

export const getJobsById = async (id) => {
  const response = await fetch(
    "http://localhost:5655/microservice/jobService/employer/jobPost/" + id,
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
  return response;
};
export const deleteJobsById = async (id, token) => {
  const response = await fetch(
    "http://localhost:5655/microservice/jobService/employer/jobPost/" + id,
    {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    }
  );
  return response;
};
