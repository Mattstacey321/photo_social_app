const checkAppLatest = r'''
   query{
           checkLatest{
              download_url
              version
              file_name
              publishDate
            }
        }
''';
