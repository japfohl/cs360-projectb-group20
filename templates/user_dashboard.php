<div class="container">
    <div class="row">
        <div class="eight columns offset-by-two">
            <h1 id="welcome" class="centered-text">Welcome - <?php echo "$fname $lname"; ?></h1>
        </div>
    </div>
    <h5>Your Values:</h5>
    <table class="u-full-width">
        <!-- Todo: Check to see if the user has values: if not display message indicating no selected values, otherwise, continue on. -->
         <?php foreach( $uservals as $val ): ?>
            <tr>
                <td class="no-bottom-border">
                    <p class="value-name"><?php echo $val["vname"]; ?></p>
                </td>
                <td class="no-bottom-border">
                    <a href="remove_value.php?user_id=<?php echo $user_id; ?>&val_id=<?php echo $val["val_id"]; ?>" class="button u-max-full-width u-pull-right">
                        Remove
                    </a>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <p><?php echo $val["vcopy"]; ?></p>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>
   
</div>

</body>