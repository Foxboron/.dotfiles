#
# Example hooks file for urlwatch
#
# Copyright (c) 2008-2016 Thomas Perl <thp.io/about>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

import re

from urlwatch import filters
from urlwatch import jobs
from urlwatch import reporters

from bs4 import BeautifulSoup

class GitHubFilter(filters.FilterBase):
    __kind__ = 'github'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")

        releases = soup.select('h1.release-title a')
        tags = soup.select('span.tag-name')

        if releases:
            results = [rel.text for rel in releases]
            return '\n'.join(results)

        elif tags:
            results = [tag.text for tag in tags]
            return '\n'.join(results)

        else:
            fallback = soup.select('div.site')
            return '\n'.join([str(tag) for tag in fallback])


class PyPIFilter(filters.FilterBase):
    __kind__ = 'pypi'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")

        downloads = soup.select('table.list tr > td > span > a:nth-of-type(1)')
        if downloads:
            downloads = [dl.text for dl in downloads]
            return '\n'.join(downloads)
        else:
            return data


class GitwebFilter(filters.FilterBase):
    __kind__ = 'gitweb'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")

        tags = soup.select('a[class="list name"]')
        if tags:
            return '\n'.join([tag.text for tag in tags])
        return data

class CGitFilter(filters.FilterBase):
    __kind__ = 'cgit'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")
        tags = soup.find_all('a', href=re.compile('/st/tag/'))
        if tags:
            return '\n'.join([tag.text for tag in tags])
        return data

class BitbucketFilter(filters.FilterBase):
    __kind__ = 'bitbucket'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")
        tags = soup.select('td[class="name"]')
        if tags:
            return '\n'.join([tag.text for tag in tags])
        return data

class AliothFilter(filters.FilterBase):
    __kind__ = 'alioth'

    def filter(self, data, subfilter=None):
        soup = BeautifulSoup(data, "html5lib")
        tags = soup.select('tr[class="align-center"] > td')
        if tags:
            return tags[1].text
        return data

class PlainTextReporter(reporters.TextReporter):
    """Custom reporter that writes the text-only report to a file"""

    __kind__ = 'plain'

    def submit(self):
        for job_state in self.report.get_filtered_job_states(self.job_states):
            if job_state.verb == 'error':
               continue
            if job_state.verb == 'new':
                continue
            if job_state.verb == 'unchanged':
                continue
            if job_state.old_data in (None, job_state.new_data):
                continue 
            ver = job_state.new_data.split()[0]
            if job_state.new_data.split()[0] == "tip":
                ver = job_state.new_data.split()[1]
            d = {"pkgname": job_state.job.pretty_name(),
                 "version": ver,
                 "url": job_state.job.get_location()}
            print("{pkgname} - {version} - {url}".format(**d))
