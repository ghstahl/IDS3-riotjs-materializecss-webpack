<simple-select>
    <div id="rolePickerContainer">
        <i if={opts.materialIcon} class="material-icons prefix">{opts.materialIcon}</i>
        <select id="selectFlow">
            <option  value="-1" disabled selected>{opts.prompt}</option>
            <option  each={opts.items} value={name}>
                {name}
            </option>
        </select>
        <label>{opts.label}</label>
    </div>

    <style></style>
    <script>
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");

        self.onSelectChanged = (e) =>{
            console.log(e)
            console.log('onSelectChanged',e.target.value)
        }

        this.on('mount', function() {
            $('#selectRole').val("1");
            $('select').material_select();
            $('#rolePickerContainer').on('change', 'select',self.onSelectChanged);

        })
    </script>
</simple-select>

