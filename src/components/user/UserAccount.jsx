import {
    Avatar,
    Box,
    Button,
    Card,
    CardActions,
    CardContent,
    Divider,
    Typography,
  } from "@mui/material";
  
  export const UserProfile = (props) => {
    return (
      <Card {...props}>
        <CardContent>
          <Box
            sx={{
              alignItems: "center",
              display: "flex",
              flexDirection: "column",
            }}
          >
            <Avatar
              src={props.user?.profilePicture}
              sx={{
                height: 64,
                mb: 2,
                width: 64,
              }}
            />
            <Typography color="textPrimary" gutterBottom variant="h5">
              {props.user?.fullName}
            </Typography>
            <Typography color="textSecondary" variant="body2">
              Email: {props.user?.email}
            </Typography>
            <Typography color="textSecondary" variant="body2">
              Location: {props.user?.location}
            </Typography>
            
          </Box>
        </CardContent>
        <Divider />
        <CardActions>
          <Button color="primary" fullWidth variant="text">
            Tutoring Status: {props.user?.status}
          </Button>
        </CardActions>
      </Card>
    );
  };