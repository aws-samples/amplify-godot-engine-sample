import "./Header.css";

import { Flex, Menu, MenuItem, Image, Link, Heading, View, Text } from "@aws-amplify/ui-react";
import { useNavigate } from "react-router-dom";
import { useAuthenticator } from '@aws-amplify/ui-react';

const Header = () => {

  const { user, signOut } = useAuthenticator((context) => [context.user]);
  const { authStatus } = useAuthenticator(context => [context.authStatus]);
  const navigate = useNavigate()

  return (
    <View className="header">
      <Flex direction="row" alignItems="center" justifyContent="space-between" className="header-layout">
        <Flex onClick={() => navigate("/")} className="header-left">
          <Image src={process.env.PUBLIC_URL + "/logo.webp"} alt="logo" width={40} height={40} />
          <Heading level={3}>Squash the Creeps</Heading>
        </Flex>
        <Flex direction="row" alignItems="center" justifyContent="space-between">
          <Flex direction="row" alignItems="center" justifyContent="space-between">
            <Link onClick={() => navigate("/")}>Home</Link>
            <Link onClick={() => navigate("/play")}>Play</Link>
            <Link onClick={() => navigate("/download")}>Download</Link>
            {/* <Link href="/play">Play</Link> */}
          </Flex>
          {
            authStatus === 'authenticated' ?
              <Flex direction="row" alignItems="center" justifyContent="space-between">
                <Text fontWeight={600}>{user?.signInDetails?.loginId}</Text>
                <Menu
                  menuAlign="end"
                  trigger={
                    <View className="header-avatar">
                      <img alt="avatar" src={process.env.PUBLIC_URL + "/avatar.png"}></img>
                    </View>
                  }
                >
                  <MenuItem>Profile</MenuItem>
                  <MenuItem onClick={() => signOut()}>Logout</MenuItem>
                </Menu>
              </Flex> : <Link onClick={() => navigate("/login")}>Login / Sign Up</Link>
          }
        </Flex>
      </Flex>
    </View >
  )
}

export default Header;