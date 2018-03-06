module Submissions
    
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
        self.class.post(url("checkpoint_submissions"), 
            body: {
                checkpoint_id: checkpoint_id,
                assignment_branch: assignment_branch,
                assignment_commit_link: assignment_commit_link,
                comment: comment,
                enrollment_id: @enrollment_id
            },
            headers: {"authorization" => @auth_token})
    end
    
end