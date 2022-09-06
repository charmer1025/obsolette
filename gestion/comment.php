<!DOCTYPE HTML>
<html>
<head>
	<?php include "inc_head.php"; ?>
	<?php 
		$langue = $_GET["langue"];
		
		$l[1] = "Français";
		$l[2] = "Allemand";
		$l[3] = "Anglais";
	?>
	<style>
		td a:hover {
			cursor:pointer;
			text-decoration:none;
		}
	</style>
</head>
<body>
	<?php include "inc_navigation.php"; ?>
	<div class="container">
	<?php if( isset($l[$langue]) ) {?>
		<h1><?php echo $l[$langue] . " : Réaction"; ?></h1>
	<?php } else { ?>
		<h1>&nbsp;</h1>
	<?php }?>
		<div class="row">
			<div class="col col-xs-12">
				<div class="table-responsive">
					<table class="table-striped table table-bordered" style="width:100%">
						<tr>
							<th>Comment</th>
							<th>Dialogues</th>
							<th>Status</th>
							<th>Updated_at</th>
							<th>Action</th>
						</tr>
					<?php 
					$comments = DB::query("SELECT c.content, c.dialog_id, c.status, c.updated_at, d.titre, c.id FROM comments c left join dialogues d on c.dialog_id = d.id where c.language_id='$langue'");
					foreach( $comments as $comment ) {
						$status = "";
						if($comment["status"] == 0) {
							$status = "<span class=\"badge btn-danger\">Pending</span>";
						}
						if($comment["status"] == 1) {
							$status = "<span class=\"badge btn-success\">Approved</span>";
						}
					?>
						<tr>
							<td><?php echo $comment["content"];?></td>
							<td>
								<a target="_blank" href="modi_histoire.php?histoire=<?php echo $comment["dialog_id"];?>"><?php echo $comment["titre"];?></a>
							</td>
							<td><?php echo $status;?></td>
							<td><?php echo $comment["updated_at"];?></td>
							<td>
								<a data-toggle="modal" data-target="#commentModal" class="btn-edit-comment" data-content="<?php echo $comment["content"]?>" data-title="<?php echo $comment["titre"]?>" data-status="<?php echo $comment["status"]?>" data-id="<?php echo $comment["id"];?>">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true" style="color:blue"></span>
								</a>
								<a href="javascript:void(0);" class="btn-delete-comment" data-id="<?php echo $comment["id"];?>">
									<span class="glyphicon glyphicon-trash" aria-hidden="true" style="color:red"></span>
								</a>
							</td>
						</tr>
					<?php
					}
					?>
					</table>					
				</div>
			</div>
		</div>
	</div>
</body>
<div class="modal" tabindex="-1" role="dialog" id="commentModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
				<input type="hidden" class="comment-id"/>
				<div class="form-group">
					<label for="recipient-name" class="col-form-label">Comment</label>
					<input type="text" class="form-control comment">
				</div>
				<div class="form-group">
					<label for="message-text" class="col-form-label">Status</label>
					<select class="form-control select-status">
						<option value="0">Pending</option>
						<option value="1">Approved</option>
					</select>
				</div>        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary btn-save-comment">Save changes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
	$(function() {
		$(".btn-delete-comment").click(function() {
			$btn = $(this);
			var result = window.confirm("Are you sure to delete this comment?");
			var id = $(this).data("id");
			if(result) {
				$.ajax({
					url:"ajax.php",
					data:{
						id:id
					},
					dataType:"json",
					type:"POST",
					success:function() {
						$btn.parent().parent().fadeOut("fast");
					}
				})
			}
		});

		$(".btn-edit-comment").click(function() {
			var title = $(this).data("title");
			var status = $(this).data("status");
			var content = $(this).data("content");
			var id=$(this).data("id");
			$(".modal .modal-title").text(title);
			$(".modal .select-status").val(status).change();
			$(".modal .comment").val(content);
			$(".modal .comment-id").val(id);
		});

		$(".btn-save-comment").click(function() {
			var comment_id = $(".modal .comment-id").val();
			var content = $(".modal .comment").val();
			var status = $(".modal .select-status").val();
			$.ajax({
				url:"ajax.php",
				data:{
					comment_id:comment_id,
					content:content,
					status:status
				},
				dataType:"json",
				type:"POST",
				success:function() {
					location.reload();
				}
			});
		});
	});
</script>
</html>