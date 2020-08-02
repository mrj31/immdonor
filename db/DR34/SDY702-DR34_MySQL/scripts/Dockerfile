FROM mysql:latest
ENV MYSQL_ROOT_PASSWORD=tcell
ENV MYSQL_DATABASE=shared_data

COPY createLkSchema.sh C:\Users\mj\mysql\SDY702-DR34_MySQL\scripts\createLkSchema.sh
COPY createResearchSchema.sh C:\Users\mj\mysql\SDY702-DR34_MySQL\scripts\createResearchSchema.sh
COPY loadLkData.sh C:\Users\mj\mysql\SDY702-DR34_MySQL\scripts\loadLkData.sh
COPY loadResearchData.sh C:\Users\mj\mysql\SDY702-DR34_MySQL\scripts\loadResearchData.sh

CMD /createLkSchema.sh localhost:3306 root tcell shared_data
CMD /createResearchSchema.sh localhost:3306 root tcell shared_data
CMD /loadLkData.sh localhost:3306 root tcell shared_data
CMD /loadResearchData.sh localhost:3306 root tcell shared_data
	
    
	
    

