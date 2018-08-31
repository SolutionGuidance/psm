<div id="modalBackground"></div>
<div id="modal">
  <div class="modal" id="writeNotesModal">
    <div class="modalHeader">
      <div class="corner">
        <div class="cornerR">
          <div class="cornerM">
            <a href="javascript:;" class="closeModal">CLOSE</a>
            <h2>Write Notes</h2>
          </div>
        </div>
      </div>
    </div>
    <!-- /.modalHeader -->
    <div class="modalBody">
      <div class="corner">
        <div class="cornerR">
          <div class="cornerM">
            <div class="container">
              <textarea rows="6" cols="60" class="textarea">Write your note here...</textarea>
              <div class="buttons">
                <a id="saveNote" href="javascript:;" class="purpleBtn saveBtn">Save</a>
                <a href="javascript:;" class="greyBtn closeModal">CANCEL</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- /.modalBody -->
    <div class="modalFooter">
      <div class="corner">
        <div class="cornerR">
          <div class="cornerM">
          </div>
        </div>
      </div>
    </div>
    <!-- /.modalFooter -->
  </div>
  <!-- /#writeNoteModal -->
  <div class="modal" id="viewNotesModal">
    <div class="modalHeader">
      <div class="corner">
        <div class="cornerR">
          <div class="cornerM">
            <a href="javascript:;" class="closeModal">CLOSE</a>
            <h2>View Notes</h2>
          </div>
        </div>
      </div>
    </div>
    <!-- /.modalHeader -->
    <div class="modalBody">
      <div class="corner">
        <div class="cornerR">
          <div class="cornerM">
            <div class="container">
              <textarea id="viewNotesModalNotesBody" rows="6" cols="60" class="textarea disable" disabled="disabled"></textarea>
              <div class="buttons">
                <div class="links">
                  <a id="prevNote" href="javascript:;">&laquo; Previous</a>
                  <a id="nextNote" href="javascript:;" class="nextLink">Next &raquo;</a>
                </div>
                <a href="javascript:;" class="greyBtn closeModal">CANCEL</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- /.modalBody -->
    <div class="modalFooter">
      <div class="corner">
        <div class="cornerR">
          <div class="cornerM">
          </div>
        </div>
      </div>
    </div>
    <!-- /.modalFooter -->
  </div>
  <!-- /#viewNotesModal -->
</div>
