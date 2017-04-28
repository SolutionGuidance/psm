package web;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.swabunga.spell.engine.Configuration;
import com.swabunga.spell.engine.SpellDictionary;
import com.swabunga.spell.engine.Word;
import com.swabunga.spell.event.SpellCheckEvent;
import com.swabunga.spell.event.SpellCheckListener;
import com.swabunga.spell.event.SpellChecker;
import com.swabunga.spell.event.StringWordTokenizer;

@Controller
@RequestMapping("/spellcheck.html")
public class SpellcheckController {
	
	protected static final Log log = LogFactory.getLog(SpellcheckController.class);

	/** All the dictionaries in the world */
	@Autowired private List<SpellDictionary> dictionaries;

	/**
	 * Embedded implementation of {@link com.swabunga.spell.event.SpellCheckListener} 
	 * responsible for recording potential errors from a list of words.
	 *
	 */
    private static class Checker implements SpellCheckListener {
        private JSONObject result;
        private JSONArray words;
        
        public void init(JSONObject result) {
            this.result = result;
            words = new JSONArray();
            try {
				this.result.put("result", words);
			} catch (JSONException e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}
        }

		public void spellingError(SpellCheckEvent event) {

        	String badWord = event.getInvalidWord();
			words.put(badWord);

        }
    }
    
    /**
	 * Embedded implementation of {@link com.swabunga.spell.event.SpellCheckListener} 
	 * responsible for recording potential replacements for a mis-spelled word.
     *
     */
    private static class Suggester implements SpellCheckListener {
        private JSONObject result;

        public void init(JSONObject result) {
            this.result = result;
        }

        @SuppressWarnings("unchecked")
		public void spellingError(SpellCheckEvent event) {

        	JSONArray suggs = new JSONArray();
            
            List<Word> suggestions = event.getSuggestions();
            if (!suggestions.isEmpty()) {
            	for(Word word : suggestions){
            		suggs.put(word.getWord());
            	}
            }
            
            try {
				result.put("result", suggs);
			} catch (JSONException e) {
				try {
					result.put("error", e.getMessage());
				} catch (JSONException argh) {
					throw new RuntimeException(argh);
				}
			}
        }
    }
    
    /**
     * Request mapping that accepts a list of space-separated words (as a single String)
     * and returns a JSON response with a list of potential errors (case insensitive) in the following format:
     * <pre>
     * {
     *     result: ["word1", "word2", ..., "wordn"]
     * }
     * </pre>
     * @param words
     * @return A list of suspect words.
     */
    @RequestMapping(params="words", method = RequestMethod.POST)
    public ResponseEntity<String> checkWordList(@RequestParam("words") String words){

		JSONObject response = new JSONObject();

		SpellChecker spellChecker = new SpellChecker();
        Configuration cfg = spellChecker.getConfiguration();
        cfg.setBoolean(Configuration.SPELL_IGNOREUPPERCASE, false);
        
        Checker chk = new Checker();
        spellChecker.addSpellCheckListener(chk);
        for (SpellDictionary dictionary : dictionaries) {
            spellChecker.addDictionary(dictionary);
        }
		
        chk.init(response);
        spellChecker.checkSpelling(new StringWordTokenizer(words.trim()));		
        		
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<String>(response.toString(), headers, HttpStatus.OK);
    }
    
    /**
     * Request mapping that accepts a single word and returns a JSON response with a list of 
     * potential replacements in the following format:
     * <pre>
     * {
     *     result: ["replacement1", "replacement2", ..., "replacementn"]
     * }
     * </pre>
     * @param word
     * @return A list of potential corrections for a mis-spelled word.
     */    
    @RequestMapping(params="word", method = RequestMethod.POST)
    public ResponseEntity<String> suggestForWord(@RequestParam("word") String word){

		JSONObject response = new JSONObject();
		
		SpellChecker spellChecker = new SpellChecker();
        Configuration cfg = spellChecker.getConfiguration();
        cfg.setBoolean(Configuration.SPELL_IGNOREUPPERCASE, false);
        
        Suggester sug = new Suggester();
        spellChecker.addSpellCheckListener(sug);
        for (SpellDictionary dictionary : dictionaries) {
            spellChecker.addDictionary(dictionary);
        }
		
        sug.init(response);
        spellChecker.checkSpelling(new StringWordTokenizer(word));			
        		
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return new ResponseEntity<String>(response.toString(), headers, HttpStatus.OK);
    }

}