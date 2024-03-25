/**
 * 
 */

const formToSerialize = (formId) => JSON.stringify([].reduce.call(document.querySelector('#' + formId), (data, element) => {
	   //이름이 있는 것을 대상으로함 
	    console.log(element);
	    if (element.name == '') return data;
	    //radio와 checkbox인 경우는 반드시 선택된 것만 대상으로함 
	    if (element.type == 'radio' || element.type == 'checkbox') {
	        if (element.checked) {
	           if (typeof data[element.name] == 'undefined') {
	              //문자열 1건 추가  
	                data[element.name] = element.value;
	           } else if(typeof data[element.name] == 'string') {
	              //문자열 값을 배열로 변경 
	              data[element.name] = [data[element.name], element.value]; 
	           } else if(typeof data[element.name] == 'object') {
	              //배열에 문자열 값을 추가  
	              data[element.name].push(element.value);
	           }
	        }
	     } else {
	        //그외는 모두 대상으로 함 
	        data[element.name] = element.value;
	     }
	     return data;
	    },
	    {} //초기값 
	 )
);
/*
url : 서버의 주소
formId : formId 또는 json 연관배열
handler : 서버에서 결과를 전달해주면 받아서 처리하는 함수 
*/

const myFetch = (url, formId, handler) => {
	const param = typeof formId == "string" ? formToSerialize(formId) : JSON.stringify(formId);
	fetch(url, {
			method:"POST",
			body : param,
			headers : {"Content-type" : "application/json; charset=utf-8"}
	}).then(res => res.json()).then(json => {
		//서버로 부터 받은 결과를 사용해서 처리 루틴 구현  
		console.log("json ", json );
		if (handler) handler(json);
	});	
}