function addComment(imageId, username) {
	
	  let commentInput = $("#comment-"+imageId);
	  let commentList = $("#comment-list-"+imageId);

	  // 유저 아이디 필요하면 매개변수로 받아와서 넣으면 됨.
	  let _data = {
	    imageId: imageId,
	    commemtText: commentInput.val(),
	  };
	  if (_data.commemtText === "") {
	    alert("댓글을 작성해주세요!");
	    return;
	  }

	  // 통신 성공하면 아래 prepend 되야 되고 ID값 필요함
	  $.ajax({
		  type: "POST",
		  url: `/image/${imageId}/comment`,
		  data: _data.commemtText,
		  contentType: "plain/text; charset=utf-8",
		  dataType: "json"
	  }).done(res=>{
		  let comment = res.data;
		  let content = `
			  <div class="sl__item__contents__comment" id="comment-${comment.id}"">
			    <p>
			      <b>${username} :</b>
			      ${_data.commemtText}
			    </p>
			    <button onClick="deleteComment(${comment.id})"><i class="fas fa-times"></i></button>
			  </div>
			  `;
			  commentList.prepend(content);
			  commentInput.val("");
	  });
	  
}

function deleteComment(commentId) {
  $.ajax({
	  type: "delete",
	  url: "/comment/"+commentId,
	  dataType: "json"
  }).done(res=>{
	  $("#comment-"+commentId).remove();
  });
}