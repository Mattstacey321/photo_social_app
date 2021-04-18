const postReaction = r'''
  mutation ($forumId: String!, $postId: String!){
      reactionPost(forumId: $forumId, postId: $postId, reactionType:heart){
        status
        success
        message
      }
    }
''';
