<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
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
