const postReaction = r'''
  mutation PostReaction($forumId: String!, $postId: String!, $reactionType: ReactionType!){
      reactionPost(forumId:"$forumId", postId:"$postId", reactionType:heart){
        status
        success
        message
      }
    }
''';
