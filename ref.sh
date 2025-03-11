#!/bin/bash
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y apt-transport-https ca-certificates dirmngr vim
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754

echo "deb https://packages.clickhouse.com/deb stable main" | sudo tee \
    /etc/apt/sources.list.d/clickhouse.list

sudo apt update

sudo DEBIAN_FRONTEND=noninteractive apt install -y clickhouse-server clickhouse-client

cat << EOF > /etc/clickhouse-server/users.xml
<clickhouse>
    <profiles>
        <default>
        </default>
        <readonly>
            <readonly>1</readonly>
        </readonly>
    </profiles>
    <users>
        <default>
            <password>password</password>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
            <access_management>1</access_management>
            <named_collection_control>1</named_collection_control>
        </default>
    </users>
    <quotas>
        <default>
            <interval>
                <duration>3600</duration>
                <queries>0</queries>
                <errors>0</errors>
                <result_rows>0</result_rows>
                <read_rows>0</read_rows>
                <execution_time>0</execution_time>
            </interval>
        </default>
    </quotas>
</clickhouse>
EOF
sudo chown clickhouse:clickhouse /etc/clickhouse-server/users.xml
sudo chmod 400 /etc/clickhouse-server/users.xml
sudo service clickhouse-server start


sudo service clickhouse-server status
sudo journalctl 