# edhtest

What is this for
----------------

 A collection of scripts, data and config files to answer a challenge 
 posed by EDH.

Usage
-----

 At your own risk, without any guarantee. The scripts can be used to automate some 
 of the actions, or as a base for more automation. Read them carefuly before using them.

 The building order should be:
<pre>
  aws_provision.sh
</pre>
 Then in the instance run
<pre>
  os_setup.sh
</pre>
 At this point, use the contents of opt/ in git and copy to the instance's /opt/. Update the ip address for nginx.
 Lastly, run the docker images as configured.
<pre>
 docker_run.sh
</pre>

 That should be enough. Point your browser to the ec2 public DNS name from the first step, and follow the links :)
