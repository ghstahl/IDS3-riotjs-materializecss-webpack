<stepper-panel>
    <div class = "stepper-panel-container">
        <div class="body">
            <yield from="body"/>
        </div>
        <div class ="footer">
            <yield from="footer"/>
        </div>
    </div>
    <style scoped>
        .stepper-panel-container .footer{
            border-top:1px solid gainsboro;
            padding-top: 4px;
        }
        .stepper-panel-container  .footer .btn, .stepper  .footer .btn-large, .stepper  .footer .btn-flat {
            float: right;
            margin: 6px 0;
        }
    </style>
    <script>
        var self = this;
    </script>
</stepper-panel>