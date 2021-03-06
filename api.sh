#!/bin/bash

echo $Actions

if [ $Actions == "policy" ] 
then
   echo "policy12346" 
    
   awk '/new/  {print $NF}' file.txt >> file2.txt

   API_ID="$(cat file2.txt)"
 
   echo "API_ID" $API_ID

   anypoint-cli --username=$USR --password=$PSW --organization=$Business_Group --environment=$Target_Environment api-mgr policy apply -c '{"credentialsOriginHasHttpBasicAuthenticationHeader":"customExpression","clientIdExpression":"#[attributes.headers[\"client_id\"]]","clientSecretExpression":"#[attributes.headers[\"client_secret\"]]"}' $API_ID client-id-enforcement --groupId 68ef9520-24e9-4cf2-b2f5-620025690913 --policyVersion 1.2.1

elif [ $Actions == "Create" ]
then
   echo "Create123"
   anypoint-cli --username=$USR --password=$PSW --organization=$Business_Group --environment=$Target_Environment api-mgr api manage --type raml $API_Asset_Id $API_Asset_Version --muleVersion4OrAbove true >> file.txt 

elif [  $Actions == "Update" ]
then

   anypoint-cli --username=$USR --password=$PSW --organization=$Business_Group --environment=$Target_Environment api-mgr api change-specification -o json $API_InstanceId $API_Asset_Version
   
elif [ $Actions == "Promote" ]
then
   anypoint-cli --username=$USR --password=$PSW --organization="$Business_Group" --environment=$Target_Environment api-mgr api promote -o json --copyPolicies true $API_InstanceId $TARGET
else
   echo "None of the condition met"
fi
