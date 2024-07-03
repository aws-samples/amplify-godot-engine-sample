import { useEffect, useState } from 'react';
import { getUrl, list } from 'aws-amplify/storage';
import { Link, Button, View, Flex, Heading } from '@aws-amplify/ui-react';

const Download = () => {

  const platforms = [
    {
      name: "Windows",
      id: "windows"
    },
    {
      name: "MacOS",
      id: "macos"
    }
  ]
  const [fileList, setFileList] = useState([]);

  const retrieveFiles = async () => {
    const files = await list({ path: 'releases/' });
    let fileListTmp = []
    platforms.forEach(element => {
      let platformBuildFileProperties = files.items.find(el => el.path.includes(element.id))
      if (platformBuildFileProperties) fileListTmp.push({ ...platformBuildFileProperties, platform: element.name })
    });
    for (var i = 0; i < fileListTmp.length; i++) {
      const linkToStorageFile = await getUrl({
        path: fileListTmp[i].path
      });
      fileListTmp[i].url = linkToStorageFile.url.toString()
    }
    setFileList(fileListTmp)
  }

  useEffect(() => {
    retrieveFiles()
  }, [])

  return (
    <View>
      <Heading marginTop={24} level={4}>Select your platform</Heading>
      <Flex marginTop={24}>
        {fileList.map((el) =>
          <Link key={el.platform} href={el.url} isExternal={true}><Button key={el.platform} variation='primary'>Download for {el.platform}</Button></Link>
        )}
      </Flex>
    </View>
  )
}

export default Download;