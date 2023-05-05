<?php
include '../../config.php';
if(isset($_GET['id']) && $_GET['id'] > 0){
    $qry = $conn->query("SELECT * from `variant_list` where id = '{$_GET['id']}' ");
    if($qry->num_rows > 0){
        foreach($qry->fetch_assoc() as $k => $v){
            $$k=$v;
        }
    }
}
?>
<div class="container-fluid">
	<form action="" id="product-form">
		<input type="hidden" name ="id" value="<?php echo isset($id) ? $id : '' ?>">

		<div class="form-group">
			<label for="brand_id" class="control-label">Brand</label>
			<select name="brand_id" id="brand_id" class="custom-select select select2">
				<option></option>
				<?php 
					$qry = $conn->query("SELECT * FROM brand_list where `type` = 1 ");
					while($row = $qry->fetch_assoc()):
				?>
				<option value="<?php echo $row['id'] ?>" <?php echo isset($brand_id) && $brand_id == $row['id'] ? "selected" : '' ?>><?php echo $row['name'] ?></option>
				<?php endwhile; ?>
			</select>
		</div>

		<div class="form-group">
		<label for="brand_id" class="control-label">Type</label>
			<select name="type_id" id="type_id" class="custom-select select select2">
				<option></option>
				<?php 
					$qry = $conn->query("SELECT * FROM type_list where `type` = 1 ");
					while($row = $qry->fetch_assoc()):
				?>
				<option value="<?php echo $row['id'] ?>" <?php echo isset($type_list) && $type_list == $row['id'] ? "selected" : '' ?>><?php echo $row['name'] ?></option>
				<?php endwhile; ?>
			</select>
		</div>

		<div class="form-group">
		<label for="variant_id" class="control-label">Variant</label>
			<select name="variant_id" id="variant_id" class="custom-select select select2">
				<option></option>
				<?php 
					$qry = $conn->query("SELECT * FROM variant_list where `type` = 1 ");
					while($row = $qry->fetch_assoc()):
				?>
				<option value="<?php echo $row['id'] ?>" <?php echo isset($variant_id) && $variant_id == $row['id'] ? "selected" : '' ?>><?php echo $row['name'] ?></option>
				<?php endwhile; ?>
			</select>
		</div>

		<div class="form-group">
			<label for="price" class="control-label">Price</label>
			<input name="price" id="price" class="form-control form text-right" value="<?php echo isset($price) ? $price : ''; ?>" />
		
	</form>
</div>
<script>
  
	$(document).ready(function(){
		$('#product-form').submit(function(e){
			e.preventDefault();
            var _this = $(this)
			 $('.err-msg').remove();
			start_loader();
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_product",
				data: new FormData($(this)[0]),
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST',
                dataType: 'json',
				error:err=>{
					console.log(err)
					alert_toast("An error occured",'error');
					end_loader();
				},
				success:function(resp){
					if(typeof resp =='object' && resp.status == 'success'){
						location.reload()
					}else if(resp.status == 'failed' && !!resp.msg){
                        var el = $('<div>')
                            el.addClass("alert alert-danger err-msg").text(resp.msg)
                            _this.prepend(el)
                            el.show('slow')
                            end_loader()
                    }else{
						alert_toast("An error occured",'error');
						end_loader();
                        console.log(resp)
					}
				}
			})
		})
        
	})
</script>